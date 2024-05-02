import Foundation
import CoreLocation
import Combine

class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {

    static let shared = BeaconDetector()

    private var locationManager: CLLocationManager?
    @Published var proximityDescription = "Searching..."
    @Published var lastKnownBeacon: MuseumBeacon?
    @Published var showAlert = false  // Flag to show alert
    @Published var potentialNewBeacon: MuseumBeacon?  // Store potential new beacon
    private var beaconSignals: [UUID: [Double]] = [:]
    private var beaconStability: [UUID: Int] = [:]
    private let stabilityThreshold = 5  // Lowered for quicker updates

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
        guard let locationManager = locationManager, CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) else {
            proximityDescription = "Beacon monitoring not available."
            return
        }

        BeaconSetup.beacons.forEach { beacon in
            let beaconRegion = CLBeaconRegion(uuid: beacon.id, identifier: beacon.identifier)
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(satisfying: CLBeaconIdentityConstraint(uuid: beacon.id))
        }
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

                if beaconStability[closestBeaconUUID]! >= stabilityThreshold && (lastKnownBeacon == nil || lastKnownBeacon!.id != closestBeaconUUID) {
                    foundNewClosest = true
                    potentialNewBeacon = beaconInfo
                }
            }

            // Update only if user confirms the new closest beacon
            if foundNewClosest {
                showAlert = true
            }
        }

        func confirmRoomChange() {
            if let newBeacon = potentialNewBeacon {
                DispatchQueue.main.async {
                    self.lastKnownBeacon = newBeacon
                    self.proximityDescription = "Close to: \(newBeacon.roomName)"
                    self.showAlert = false
                    self.potentialNewBeacon = nil
                }
            }
        }
}
