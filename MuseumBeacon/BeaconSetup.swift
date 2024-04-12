//
//  BeaconSetup.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 12/04/24.
//

import Foundation

struct MuseumBeacon {
    var uuid: UUID
    var identifier: String
    var roomName: String
}

struct BeaconSetup {
    static let beacons: [MuseumBeacon] = [
        ("B5B182C7-EAB1-4988-AA99-B5C1517008D9", "Beacon1", "Ancient Egypt"),
        ("5AFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF", "Beacon2", "Renaissance Art"),
        ("74278BDA-B644-4520-8F0C-720EAF059935", "Beacon3", "Modern Sculptures"),
        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647825", "Beacon4", "Contemporary Paintings"),
        ("D0D3FA86-CA76-45EC-9BFD-CA5AFA9F14DD", "Beacon5", "Dinosaurs")
    ].compactMap { createMuseumBeacon(uuidString: $0.0, identifier: $0.1, roomName: $0.2) }
    
    private static func createMuseumBeacon(uuidString: String, identifier: String, roomName: String) -> MuseumBeacon? {
        guard let uuid = UUID(uuidString: uuidString) else {
            print("Error: Invalid UUID string provided for \(identifier) with room \(roomName)")
            return nil
        }
        return MuseumBeacon(uuid: uuid, identifier: identifier, roomName: roomName)
    }
}

