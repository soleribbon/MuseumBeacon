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
    var artist: String
}

struct BeaconSetup {
    static let beacons: [MuseumBeacon] = [
        
        
        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647822", "Beacon1", "The Last Judgement", "entrance", "You are at the entrance. From the entrance, to the left you have reception and waiting areas, straight the cafeteria and auditorium hallway junction, right a standing waiting area.", "Michelangelo"),

        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647823", "Beacon2", "The Scream", "reception", "You are in the reception area. Nearby you'll find a waiting area with seating.", "Edvard Munch"),

        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647824", "Beacon3", "Guernica", "waiting", "You are in the waiting area left of the reception desk. There are chairs to sit down.", "Pablo Picasso"),

        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647825", "Beacon4", "Composition X", "standing", "You are in the standing waiting area to the right of the entrance doors (looking inward).", "Wassily Kandinsky"),

        ("FDA50693-A4E2-4FB1-AFCF-C6EB07647826", "Beacon5", "Gioconda", "junction", "You are in the center junction area with hallways to the cafeteria, auditorium, and reception area.", "Amilcare Ponchielli")
    ].compactMap { createMuseumBeacon(uuidString: $0.0, identifier: $0.1, roomName: $0.2, imageName: $0.3, description: $0.4, artist: $0.5)}

    private static func createMuseumBeacon(uuidString: String, identifier: String, roomName: String, imageName: String, description: String, artist: String) -> MuseumBeacon? {
        guard let uuid = UUID(uuidString: uuidString) else {
            print("Error: Invalid UUID string provided for \(identifier) with room \(roomName)")
            return nil
        }
        return MuseumBeacon(id: uuid, identifier: identifier, roomName: roomName, imageName: imageName, description: description, artist: artist)
    }
}

