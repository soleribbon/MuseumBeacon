//
//  BeaconSetup.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 12/04/24.
//

import Foundation

struct MuseumBeacon: Identifiable, Hashable {
    var id: UUID
    var identifier: String
    var roomName: String
    var imageName: String
    var description: String
    var moreInformation: String?
    var subtitle: String
    var nearbyRooms: [String: String]
    var suggestedPaths: [String: [String]]?
}

struct BeaconSetup {
    static let beacons: [MuseumBeacon] = [

        //TESTS (3)
//        createMuseumBeacon(
//            uuidString: "A672E202-A268-4A81-AA5E-58C726A0E3AC",
//            identifier: "Beacon1",
//            roomName: "Main Lobby",
//            imageName: "entrance",
//            description: "Welcome to the Headquarters of the World Food Programme. This is the Main Lobby. On your left, the Information desk. On the right, the Nobel Prize Medal and Certificate. In front of you, the corridor that leads you to the Auditorium.",
//            moreInformation: "This area serves as the primary entrance to WFP headquarters, including a Nobel Prize Medal exhibition.",
//            subtitle: "Entrance Area",
//            nearbyRooms: [
//                "Reception Area": "SOUTH",
//                "Corridors Junction": "WEST",
//                "Nobel Peace Prize": "NORTHWEST",
//                "Exit": "NORTHEAST"
//            ],
//            suggestedPaths: [
//                "Auditorium": ["Main Lobby", "Reception Area", "Corridors Junction", "Auditorium Corridor", "Auditorium"],
//                "Nobel Prize": ["Main Lobby", "Reception Area", "Corridors Junction", "Nobel Peace Prize"],
//            ]
//        ),
//        createMuseumBeacon(
//            uuidString: "B803D06E-35D8-4731-A16C-55C660182DD4",
//            identifier: "Beacon2",
//            roomName: "Reception Area",
//            imageName: "reception",
//            description: "You have reached the Information and Registration Desk.",
//            subtitle: "Check In",
//            nearbyRooms: [
//                "Exit": "NORTHEAST",
//                "Nobel Peace Prize": "NORTH",
//                "Corridors Junction": "WEST"
//            ],
//            suggestedPaths: [
//                "Auditorium": ["Corridors Junction", "Auditorium Corridor"]
//        
//            ]
//        ),
//        
//        createMuseumBeacon(
//            uuidString: "104AF95D-B094-4BE2-BC7F-9417F5372347",
//            identifier: "Beacon4",
//            roomName: "Nobel Prize",
//            imageName: "nobelPrizeArea",
//            description: "You are in a standing area to the right of the entrance doors. This area includes the World Food Programme's Nobel Prize.",
//            moreInformation: "In 2020, the Nobel Peace Prize was awarded to the World Food Programme (WFP) for its efforts to combat hunger and improve conditions for peace in conflict-affected areas. The Nobel Committee recognized the WFP for its crucial role in addressing food insecurity, which is exacerbated by war and conflict, and for its contribution to the prevention of hunger being used as a weapon of war and conflict. The award highlighted the importance of food security in promoting peace and stability, particularly in regions suffering from protracted crises. The WFP's efforts have saved countless lives and underscored the need for global solidarity in tackling hunger and fostering peace.",
//            subtitle: "Award Area",
//            nearbyRooms: [
//                "Exit": "EAST",
//                "Reception Area": "SOUTHEAST",
//            ],
//            suggestedPaths: nil
//        ),


        //below are REAL
        createMuseumBeacon(
            uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647822",
            identifier: "Beacon1",
            roomName: "Main Lobby",
            imageName: "entrance",
            description: "Welcome to the Headquarters of the World Food Programme. This is the Main Lobby. On your left, the Information desk. On the right, the Nobel Prize Medal and Certificate. In front of you, the corridor that leads you to the Auditorium.",
            moreInformation: "This area serves as the primary entrance to WFP headquarters, including a Nobel Prize Medal exhibition.",
            subtitle: "Entrance Area",
            nearbyRooms: [
                "Reception Area": "SOUTH",
                "Corridors Junction": "WEST",
                "Nobel Peace Prize": "NORTHWEST",
                "Exit": "NORTHEAST"
            ],
            suggestedPaths: [
                "Auditorium": ["Main Lobby", "Reception Area", "Corridors Junction", "Auditorium Corridor", "Auditorium"],
                "Nobel Prize": ["Main Lobby", "Reception Area", "Corridors Junction", "Nobel Peace Prize"],
            ]
        ),


        createMuseumBeacon(
            uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647823",
            identifier: "Beacon2",
            roomName: "Reception Area",
            imageName: "reception",
            description: "You have reached the Information and Registration Desk.",
            subtitle: "Check In",
            nearbyRooms: [
                "Exit": "NORTHEAST",
                "Nobel Peace Prize": "NORTH",
                "Corridors Junction": "WEST"
            ],
            suggestedPaths: [
                "Auditorium": ["Reception Area", "Corridors Junction", "Auditorium Corridor", "Auditorium"],
            ]
        ),
        //NEW BEACON PLACEMENT
        createMuseumBeacon(
            uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647824",
            identifier: "Beacon3",
            roomName: "Auditorium Corridor",
            imageName: "auditoriumCorridor",
            description: "This is the corridor that leads to the Auditorium. The Documents desk is at the end of the corridor. There are two big doors, one on the right of the Documents Desk and one on its left. Both doors lead to the Auditorium.",
            subtitle: "Hallway",
            nearbyRooms: [
                "Auditorium": "SOUTH",
                "Exit": "NORTHEAST",
                "Information Desk": "NORTHEAST"
            ],
            suggestedPaths: [
                "Reception Desk": ["Auditorium Corridor", "Corridors Junction", "Reception Area"],
                "Nobel Prize": ["Auditorium Corridor", "Corridors Junction", "Reception Area", "Main Lobby", "Nobel Prize"]
            ]
        ),

        createMuseumBeacon(
            uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647825",
            identifier: "Beacon4",
            roomName: "Nobel Prize",
            imageName: "nobelPrizeArea",
            description: "You are in a standing area to the right of the entrance doors. This area includes the World Food Programme's Nobel Prize.",
            moreInformation: "In 2020, the Nobel Peace Prize was awarded to the World Food Programme (WFP) for its efforts to combat hunger and improve conditions for peace in conflict-affected areas. The Nobel Committee recognized the WFP for its crucial role in addressing food insecurity, which is exacerbated by war and conflict, and for its contribution to the prevention of hunger being used as a weapon of war and conflict. The award highlighted the importance of food security in promoting peace and stability, particularly in regions suffering from protracted crises. The WFP's efforts have saved countless lives and underscored the need for global solidarity in tackling hunger and fostering peace.",
            subtitle: "Award Area",
            nearbyRooms: [
                "Exit": "EAST",
                "Information Desk": "SOUTHEAST"
            ],
            suggestedPaths: [
                "Auditorium": ["Nobel Prize Area", "Main Lobby", "Reception Area", "Corridors Junction", "Auditorium Corridor", "Auditorium"]
            ]
        ),

        createMuseumBeacon(
            uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647826",
            identifier: "Beacon5",
            roomName: "The Corridor",
            imageName: "junction",
            description: "This is the corridor that connects the Main Lobby to the Auditorium. On the right, the Blue Cafeteria and on the left, the Red Cafè.",
            subtitle: "Central Junction",
            nearbyRooms: [
                "Reception Area": "EAST",
                "Auditorium Corridor": "WEST",
                "Exit": "EAST"
            ],
            suggestedPaths: [
                "Nobel Prize": ["Corridors Junction", "Reception Area", "Main Lobby", "Nobel Prize"],
                "Auditorium": ["Corridors Junction", "Auditorium Corridor", "Auditorium"]
            ]
        )


    ].compactMap { $0 }

    private static func createMuseumBeacon(uuidString: String, identifier: String, roomName: String, imageName: String, description: String, moreInformation: String? = nil, subtitle: String, nearbyRooms: [String: String], suggestedPaths: [String: [String]]? = nil) -> MuseumBeacon? {
        guard let uuid = UUID(uuidString: uuidString) else {
            print("Error: Invalid UUID string provided for \(identifier) with room \(roomName)")
            return nil
        }
        return MuseumBeacon(id: uuid, identifier: identifier, roomName: roomName, imageName: imageName, description: description, moreInformation: moreInformation, subtitle: subtitle, nearbyRooms: nearbyRooms, suggestedPaths: suggestedPaths)
    }
}

//TEST BEACONS
//
//
//createMuseumBeacon(
//    uuidString: "A672E202-A268-4A81-AA5E-58C726A0E3AC",
//    identifier: "Beacon1",
//    roomName: "Main Lobby",
//    imageName: "entrance",
//    description: "Welcome to the Headquarters of the World Food Programme. This is the Main Lobby. On your left, the Information desk. On the right, the Nobel Prize Medal and Certificate. In front of you, the corridor that leads you to the Auditorium.",
//    moreInformation: "This area serves as the primary entrance to WFP headquarters, including a Nobel Prize Medal exhibition.",
//    subtitle: "Entrance Area",
//    nearbyRooms: [
//        "Reception Area": "SOUTH",
//        "Corridors Junction": "WEST",
//        "Nobel Peace Prize": "NORTHWEST",
//        "Exit": "NORTHEAST"
//    ],
//    suggestedPaths: [
//        "Auditorium": ["Main Lobby", "Reception Area", "Corridors Junction", "Auditorium Corridor", "Auditorium"],
//        "Nobel Prize": ["Main Lobby", "Reception Area", "Corridors Junction", "Nobel Peace Prize"],
//    ]
//),
//createMuseumBeacon(
//    uuidString: "B803D06E-35D8-4731-A16C-55C660182DD4",
//    identifier: "Beacon2",
//    roomName: "Reception Area",
//    imageName: "reception",
//    description: "You have reached the Information and Registration Desk.",
//    subtitle: "Check In",
//    nearbyRooms: [
//        "Exit": "NORTHEAST",
//        "Nobel Peace Prize": "NORTH",
//        "Corridors Junction": "WEST"
//    ],
//    suggestedPaths: [
//        "Auditorium": ["Corridors Junction", "Auditorium Corridor"]
//
//    ]
//),
//
//createMuseumBeacon(
//    uuidString: "104AF95D-B094-4BE2-BC7F-9417F5372347",
//    identifier: "Beacon4",
//    roomName: "Nobel Prize",
//    imageName: "nobelPrizeArea",
//    description: "You are in a standing area to the right of the entrance doors. This area includes the World Food Programme's Nobel Prize.",
//    moreInformation: "In 2020, the Nobel Peace Prize was awarded to the World Food Programme (WFP) for its efforts to combat hunger and improve conditions for peace in conflict-affected areas. The Nobel Committee recognized the WFP for its crucial role in addressing food insecurity, which is exacerbated by war and conflict, and for its contribution to the prevention of hunger being used as a weapon of war and conflict. The award highlighted the importance of food security in promoting peace and stability, particularly in regions suffering from protracted crises. The WFP's efforts have saved countless lives and underscored the need for global solidarity in tackling hunger and fostering peace.",
//    subtitle: "Award Area",
//    nearbyRooms: [
//        "Exit": "EAST",
//        "Reception Area": "SOUTHEAST",
//    ],
//    suggestedPaths: nil
//)
