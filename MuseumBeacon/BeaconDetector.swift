//
//  BeaconDetector.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 05/04/24.
//


import Combine
import CoreLocation

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    @Published var proximityDescription = "Searching..."

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
        case .notDetermined:
            // Wait for authorization callback
            break
        case .restricted, .denied:
            proximityDescription = "Location access is restricted or denied."
        case .authorizedAlways, .authorizedWhenInUse:
            startScanning()
        @unknown default:
            proximityDescription = "Unexpected authorization status."
        }
    }

    func startScanning() {
        guard let locationManager = locationManager, CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) else {
            proximityDescription = "Beacon monitoring not available."
            return
        }

        let beacons = BeaconSetup.beacons
        for beacon in beacons {
            let beaconRegion = CLBeaconRegion(uuid: beacon.uuid, identifier: beacon.identifier)
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon.uuid))
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updateAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard let closestBeacon = beacons.min(by: { $0.accuracy < $1.accuracy }), closestBeacon.proximity != .unknown else {
            proximityDescription = "Searching..."
            return
        }

        let beaconInfo = BeaconSetup.beacons.first(where: { $0.uuid == closestBeacon.uuid })
        updateProximityDescription(beacon: closestBeacon, beaconInfo: beaconInfo)
    }

    private func updateProximityDescription(beacon: CLBeacon, beaconInfo: MuseumBeacon?) {
        let distanceString = String(format: "%.2f meters", beacon.accuracy)
        switch beacon.proximity {
        case .immediate:
            proximityDescription = "\(beaconInfo?.roomName ?? "Unknown"): Very close (\(distanceString))"
        case .near:
            proximityDescription = "\(beaconInfo?.roomName ?? "Unknown"): Near (\(distanceString))"
        case .far:
            proximityDescription = "\(beaconInfo?.roomName ?? "Unknown"): Far (\(distanceString))"
        default:
            // Handle unhandled cases but do not modify the state
            return
        }
    }
}
