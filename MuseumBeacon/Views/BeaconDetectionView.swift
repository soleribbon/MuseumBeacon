//
//  BeaconDetectionView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 03/09/24.
//

import SwiftUI

struct BeaconInfo: Identifiable {
    let id: UUID
    let name: String
    let accuracy: Double
}

struct BeaconDetectionView: View {
    @ObservedObject var detector = BeaconDetector.shared
    
    var body: some View {
        NavigationView {
            List(detector.detectedBeacons) { beacon in
                VStack(alignment: .leading, spacing: 4) {
                    Text(beacon.name)
                        .font(.headline)
                    Text("Accuracy: \(String(format: "%.2f", beacon.accuracy)) meters")
                        .font(.subheadline)
                    Text("UUID: \(beacon.id)")
                        .font(.caption2)
                        .opacity(0.25)
                }
            }
            .navigationTitle("Nearby Beacons")
        }
        .onAppear {
            detector.startScanning()
        }
        .onDisappear {
            detector.stopScanning()
        }
    }
}

#Preview {
    BeaconDetectionView()
}
