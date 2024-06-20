//
//  BeaconDetector.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne
//


import Foundation
import CoreLocation
import Combine
import AVFoundation
import UIKit
import SwiftUI
import CoreMotion

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {

    static let shared = BeaconDetector()

    private var locationManager: CLLocationManager?
    private let motionManager = CMMotionManager()
    @Published var proximityDescription = "Searching..."
    @Published var lastKnownBeacon: MuseumBeacon?
    @Published var potentialNewBeacon: MuseumBeacon?
    private var beaconSignals: [UUID: [Double]] = [:]
    private var beaconStability: [UUID: Int] = [:]

    private let stabilityThreshold = 4 //edit for fast detection (<accuracy)

    private var lastAnnouncedRoom: UUID?
    var speechSynthesizer = AVSpeechSynthesizer()

    var lastHeading: Int?

    @Published var currentDirection: String = "Unknown Orientation" // For updating subtitle


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

        // Set for faster updates - disable for better battery life
        //        locationManager.distanceFilter = kCLDistanceFilterNone // No distance filter
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Highest accuracy

        // Start heading updates
        if CLLocationManager.headingAvailable() {
            locationManager.headingFilter = 5 // Update on every 5 degree change
            locationManager.startUpdatingHeading()
        }

        BeaconSetup.beacons.forEach { beacon in
            let beaconRegion = CLBeaconRegion(uuid: beacon.id, identifier: beacon.identifier)
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon.id))
        }

        startDeviceOrientationUpdates()

        print("STARTED SCANNING")
    }



    func stopScanning() {
        guard let locationManager = locationManager else { return }

        BeaconSetup.beacons.forEach { beacon in
            let beaconRegion = CLBeaconRegion(uuid: beacon.id, identifier: beacon.identifier)
            locationManager.stopMonitoring(for: beaconRegion)
            locationManager.stopRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon.id))
        }

        motionManager.stopDeviceMotionUpdates() //Stop compass heading & motion updates
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

    func speak(_ text: String, ignoreVoiceOverCheck: Bool = false) {
        // Ensure the speech synthesis is done on a high-priority queue
        DispatchQueue.global(qos: .userInitiated).async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5
            self.speechSynthesizer.speak(utterance)
        }
    }


    func startDeviceOrientationUpdates() {
        motionManager.deviceMotionUpdateInterval = 1.0 // Compass update interval
        motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main) { [weak self] (motionData: CMDeviceMotion?, error: Error?) in
            guard let self = self, let motion = motionData else { return }
            let heading = Int(motion.heading)

            // Use a threshold to reduce unnecessary updates
            if self.lastHeading == nil || abs(self.lastHeading! - heading) >= 1 {
                self.lastHeading = heading
                let direction = self.compassDirection(from: heading)
                self.currentDirection = "LOOKING \(direction)"
                //                print("Heading: \(heading)° \(direction)")
            }
        }
    }

    func determineRelativeDirections(for beacon: MuseumBeacon) -> [String: Double] {
        var relativeDirections: [String: Double] = [:]
        for (room, direction) in beacon.nearbyRooms {
            if let heading = lastHeading {
                let relativeDirection = calculateRelativeDirection(from: heading, to: direction)
                relativeDirections[room] = relativeDirection
            } else {
                relativeDirections[room] = compassDegrees(for: direction)
            }
        }
        return relativeDirections
    }

    func calculateRelativeDirection(from heading: Int, to direction: String) -> Double {
        // Calculates the relative direction based on the user's heading and the target direction.
        let directionDegrees = compassDegrees(for: direction)
        let relativeDegrees = (directionDegrees - Double(heading) + 360).truncatingRemainder(dividingBy: 360)
        return relativeDegrees
    }

    //RETURNS DEGREES FROM DIRECTION FORM (parsing nearbyRooms)
    func compassDegrees(for direction: String) -> Double {
        switch direction {
        case "NORTH":
            return 0
        case "NORTHEAST":
            return 45
        case "EAST":
            return 90
        case "SOUTHEAST":
            return 135
        case "SOUTH":
            return 180
        case "SOUTHWEST":
            return 225
        case "WEST":
            return 270
        case "NORTHWEST":
            return 315
        default:
            return 0
        }
    }


    //RETURNS DIRECTION IN WORD FORM FOR SUBTITLE
    func compassDirection(from heading: Int) -> String {
        switch heading {
        case 0..<23, 338..<360:
            return "NORTH"
        case 23..<68:
            return "NORTHEAST"
        case 68..<113:
            return "EAST"
        case 113..<158:
            return "SOUTHEAST"
        case 158..<203:
            return "SOUTH"
        case 203..<248:
            return "SOUTHWEST"
        case 248..<293:
            return "WEST"
        case 293..<338:
            return "NORTHWEST"
        default:
            return "NORTH"
        }
    }
}

