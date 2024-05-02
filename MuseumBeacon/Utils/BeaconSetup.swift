//
//  BeaconSetup.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 12/04/24.
//

import Foundation

struct MuseumBeacon: Identifiable, Hashable {
    var id: UUID

//    var uuid: UUID
    var identifier: String
    var roomName: String
    var imageName: String
    var description: String
    var dateRange: String
}

struct BeaconSetup {
    static let beacons: [MuseumBeacon] = [
        
        
        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647822", "Beacon1", "Kitchen Era", "room1Image", "Explore the wonders of Ancient Egyptian artifacts and hieroglyphs.", "3200 BC to 30 BC"),
        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647823", "Beacon2", "Big Chungus Era", "room2Image", "Explore the wonders of Ancient Egyptian artifacts and hieroglyphs.", "4200 BC to 40 BC"),
        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647824", "Beacon3", "My Bedroom Era", "room3Image", "Explore the wonders of Ancient Egyptian artifacts and hieroglyphs.", "5200 BC to 50 BC"),
        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647825", "Beacon4", "Tableroom Era", "room4Image", "Explore the wonders of Ancient Egyptian artifacts and hieroglyphs.", "6200 BC to 60 BC"),
        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647826", "Beacon5", "Do Not Go Era", "room5Image", "Explore the wonders of Ancient Egyptian artifacts and hieroglyphs.", "3200 BC to 70 BC")
    ].compactMap { createMuseumBeacon(uuidString: $0.0, identifier: $0.1, roomName: $0.2, imageName: $0.3, description: $0.4, dateRange: $0.5)}
    
    private static func createMuseumBeacon(uuidString: String, identifier: String, roomName: String, imageName: String, description: String, dateRange: String) -> MuseumBeacon? {
        guard let uuid = UUID(uuidString: uuidString) else {
            print("Error: Invalid UUID string provided for \(identifier) with room \(roomName)")
            return nil
        }
        return MuseumBeacon(id: uuid, identifier: identifier, roomName: roomName, imageName: imageName, description: description, dateRange: dateRange)
    }
}

