import Foundation
import CoreLocation
import Combine
import AVFoundation
import UIKit
import SwiftUI

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = BeaconDetector()
    
    private var locationManager: CLLocationManager?
    @Published var proximityDescription = "Searching..."
    @Published var lastKnownBeacon: MuseumBeacon?
    @Published var potentialNewBeacon: MuseumBeacon?
    private var beaconSignals: [UUID: [Double]] = [:]
    private var beaconStability: [UUID: Int] = [:]
    private let stabilityThreshold = 5
    
    private var lastAnnouncedRoom: UUID?
    var speechSynthesizer = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        locationManager?.requestAlwaysAuthorization()
        updateAuthorization()
    }
    
    func updateAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            proximityDescription = "Location access is restricted or denied."
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            startScanning()
        default:
            proximityDescription = "Unexpected authorization status."
        }
    }
    
    func startScanning() {
        proximityDescription = "Searching..."
        guard let locationManager = locationManager, CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) else {
            proximityDescription = "Beacon monitoring not available."
            return
        }
        
        BeaconSetup.beacons.forEach { beacon in
            let beaconRegion = CLBeaconRegion(uuid: beacon.id, identifier: beacon.identifier)
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon.id))
        }
        print("STARTED SCANNING")
    }
    
    func stopScanning() {
        guard let locationManager = locationManager else { return }
        
        BeaconSetup.beacons.forEach { beacon in
            let beaconRegion = CLBeaconRegion(uuid: beacon.id, identifier: beacon.identifier)
            locationManager.stopMonitoring(for: beaconRegion)
            locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon.id))
        }
        
        proximityDescription = "Scanning stopped."
        lastKnownBeacon = nil
        potentialNewBeacon = nil
        beaconSignals.removeAll()
        beaconStability.removeAll()
        lastAnnouncedRoom = nil
        print("STOPPED SCANNING")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        var foundNewClosest = false
        
        for beacon in beacons.filter({ $0.proximity != .unknown && $0.accuracy > 0 }) {
            let beaconKey = beacon.uuid
            beaconSignals[beaconKey, default: []].append(beacon.accuracy)
            if beaconSignals[beaconKey]!.count > 10 { beaconSignals[beaconKey]!.removeFirst() }
        }
        
        let sortedBeacons = beaconSignals.keys.sorted {
            (beaconSignals[$0]!.reduce(0, +) / Double(beaconSignals[$0]!.count)) <
                (beaconSignals[$1]!.reduce(0, +) / Double(beaconSignals[$1]!.count))
        }
        
        if let closestBeaconUUID = sortedBeacons.first,
           let beaconInfo = BeaconSetup.beacons.first(where: { $0.id == closestBeaconUUID }) {
            beaconStability[closestBeaconUUID, default: 0] += 1
            
            if beaconStability[closestBeaconUUID]! >= stabilityThreshold && (lastKnownBeacon == nil || lastKnownBeacon!.id != closestBeaconUUID) &&
                (lastAnnouncedRoom != closestBeaconUUID) {
                foundNewClosest = true
                potentialNewBeacon = beaconInfo
            }
        }
        
        // Update only if user confirms the new closest beacon
        if foundNewClosest {
            confirmRoomChange()
        }
    }
    
    func confirmRoomChange() {
        if let newBeacon = potentialNewBeacon {
            DispatchQueue.main.async {
                self.lastKnownBeacon = newBeacon
                self.proximityDescription = "Close to: \(newBeacon.roomName)"
                self.potentialNewBeacon = nil
                if self.lastAnnouncedRoom != newBeacon.id {
                    self.speak("\(newBeacon.roomName).  \(newBeacon.description)")
                    
                    // Update the last announced room
                    self.lastAnnouncedRoom = newBeacon.id
                }
            }
        }
        
    }
    
    // BeaconDetector.swift adjustments for speak function:
    func speak(_ text: String, ignoreVoiceOverCheck: Bool = false) {
        // Ensure the speech synthesis is done on a high-priority queue
        DispatchQueue.global(qos: .userInitiated).async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5
            self.speechSynthesizer.speak(utterance)
        }
    }
    
    
    
    
}
