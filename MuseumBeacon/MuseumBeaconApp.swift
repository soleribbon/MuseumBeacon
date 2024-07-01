//
//  MuseumBeaconApp.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 05/04/24.
//

import SwiftUI

@main
struct MuseumBeaconApp: App {
    var body: some Scene {
        WindowGroup {
            //            InteractiveUpdatesView()
            //            RoomView(beacon: BeaconSetup.beacons[0])
            //                .previewDisplayName(BeaconSetup.beacons[0].roomName)
            MainStartView()
        }
    }
}
