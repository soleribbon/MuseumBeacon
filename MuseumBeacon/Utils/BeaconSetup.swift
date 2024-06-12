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
    var moreInformation: String?
    var subtitle: String
}

struct BeaconSetup {
    static let beacons: [MuseumBeacon] = [
        createMuseumBeacon(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647822", identifier: "Beacon1", roomName: "Main Lobby", imageName: "entrance", description: "Welcome to the Headquarters of the World Food Programme. This is the Main Lobby. On your left, the Information desk. On the right, the Nobel Prize Medal and Certificate. In front of you, the corridor that leads you to the Auditorium.", moreInformation: "This area serves as the primary entrance to WFP headquarters, including a Nobel Prize Medal exhibition.", subtitle: "Entrance Area"),
        
        createMuseumBeacon(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647823", identifier: "Beacon2", roomName: "Reception Area", imageName: "reception", description: "You have reached the Information and Registration Desk.", subtitle: "Check In"),
        //NEW PLACEMENT
        createMuseumBeacon(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647824", identifier: "Beacon3", roomName: "Auditorium Corridor", imageName: "auditoriumCorridor", description: "This is the corridor that leads to the Auditorium. The Documents desk is at the end of the corridor. There are two big doors, one on the right of the Documents Desk and one on its left. Both doors lead to the Auditorium.", subtitle: "Hallway"),
        
        createMuseumBeacon(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825", identifier: "Beacon4", roomName: "Nobel Prize", imageName: "nobelPrizeArea", description: "You are in a standing area to the right of the entrance doors. This area includes the World Food Programme's Nobel Prize.", moreInformation: "In 2020, the Nobel Peace Prize was awarded to the World Food Programme (WFP) for its efforts to combat hunger and improve conditions for peace in conflict-affected areas. The Nobel Committee recognized the WFP for its crucial role in addressing food insecurity, which is exacerbated by war and conflict, and for its contribution to the prevention of hunger being used as a weapon of war and conflict. The award highlighted the importance of food security in promoting peace and stability, particularly in regions suffering from protracted crises. The WFP's efforts have saved countless lives and underscored the need for global solidarity in tackling hunger and fostering peace.", subtitle: "Award Area"),
        
        createMuseumBeacon(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647826", identifier: "Beacon5", roomName: "The Corridor", imageName: "junction", description: "This is the corridor that connects the Main Lobby to the Auditorium. On the right, the Blue Cafeteria and on the left, the Red Cafè.", subtitle: "Central Junction")
    ].compactMap { $0 }
    
    private static func createMuseumBeacon(uuidString: String, identifier: String, roomName: String, imageName: String, description: String, moreInformation: String? = nil, subtitle: String) -> MuseumBeacon? {
        guard let uuid = UUID(uuidString: uuidString) else {
            print("Error: Invalid UUID string provided for \(identifier) with room \(roomName)")
            return nil
        }
        return MuseumBeacon(id: uuid, identifier: identifier, roomName: roomName, imageName: imageName, description: description, moreInformation: moreInformation, subtitle: subtitle)
    }
}

