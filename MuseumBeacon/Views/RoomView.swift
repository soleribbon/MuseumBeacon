//
//  RoomView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 10/05/24.
//

import SwiftUI
import UIKit
struct RoomView: View {
    let beacon: MuseumBeacon
    @Environment(\.dismiss) var dismiss
    let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    @ObservedObject var beaconDetector = BeaconDetector.shared
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    GeometryReader { geometry in
                        Image(beacon.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: 300)
                            .clipped()
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2)
                            .accessibilityHidden(true)
                    }.frame(height: 300)
                    VStack (alignment: .leading, spacing: 10){
                        VStack (alignment: .leading, spacing: 8){
                            VStack (alignment: .leading, spacing: 0){
                                //  Text(beacon.subtitle)
                                //                              .font(.avenirNextRegular(size: 16))
                                //                                .foregroundColor(.gray)
                                //                               .accessibilityAddTraits(.isHeader)
                                Text(beaconDetector.currentDirection)
                                    .font(.avenirNextRegular(size: 16))
                                    .foregroundColor(.gray)
                                    .accessibilityAddTraits(.isHeader)
                                    .accessibilityElement(children: .ignore)
                                    .accessibilityLabel(beaconDetector.currentDirection)

                                Text(beacon.roomName)
                                    .font(.avenirNext(size: 28))
                                    .bold()
                                    .foregroundStyle(Color("wfpBlue"))
                                    .accessibilityAddTraits(.isHeader)
                            }
                            
                            Text(beacon.description)
                                .lineLimit(nil)
                                .font(.avenirNextRegular(size: 18))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("wfpBlack"))
                                .lineSpacing(4)
                                .accessibilityAddTraits(.isHeader)
                            Spacer()
                            
                            if !beacon.nearbyRooms.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("NEARBY")
                                        .lineLimit(nil)
                                        .font(.avenirNextRegular(size: 18))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color("wfpBlue"))
                                        .accessibilityAddTraits(.isHeader)
                                        .accessibilityLabel(nearbyRoomsAccessibilityLabel())
                                    ForEach(beacon.nearbyRooms.sorted(by: <), id: \.key) { room, direction in
                                        HStack {
                                            DirectionArrow(directionDegrees: beaconDetector.calculateRelativeDirection(from: beaconDetector.lastHeading ?? 0, to: direction))
                                            Text(room)
                                                .font(.avenirNextRegular(size: 18))
                                                .foregroundColor(.gray)
                                            Spacer()
                                            
                                        }.accessibilityHidden(true)
                                    }
                                }.accessibilityElement(children: .combine)
                            }
                            
                        }
                        Spacer()
                        
                        
                        if let moreInformation = beacon.moreInformation, !moreInformation.isEmpty {
                            Text("MORE INFORMATION")
                                .lineLimit(nil)
                                .font(.avenirNextRegular(size: 18))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("wfpBlue"))
                                .accessibilityAddTraits(.isHeader)
                            
                            Text(moreInformation)
                                .lineLimit(nil)
                                .font(.avenirNextRegular(size: 18))
                                .foregroundStyle(Color("wfpBlack"))
                                .lineSpacing(4)
                                .accessibilityAddTraits(.isHeader)
                        }
                        
                        Spacer()
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16.0)
                }
                .edgesIgnoringSafeArea(.all)
                
                NavigationLink(destination: AllRoomsView()) {
                    Text("View All Points of Interest")
                        .font(.avenirNext(size: 18))
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                        .background(Color("wfpBlue"))
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                        .accessibilityLabel("View All Points of Interest")
                        .padding(.horizontal)
                    
                }
                Button(action: {
                    impactRigid.impactOccurred()
                    dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "escape")
                        Text("Exit Guide Mode")
                            .font(.avenirNext(size: 18))
                    }
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("wfpRed"))
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                    .accessibilityLabel("Exit Guide Mode")
                    .padding(.horizontal)
                })
            }
            
            
        }
    }
    
    private func nearbyRoomsAccessibilityLabel() -> String {
        var label = "Nearby destinations: "
        let directions = beaconDetector.determineRelativeDirections(for: beacon)
        for (room, degrees) in directions {
            let direction = directionFromDegrees(degrees)
            label += "\(room) is to the \(direction). "
        }
        return label
    }
    
    private func directionFromDegrees(_ degrees: Double) -> String {
        switch degrees {
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
            return "unknown"
        }
    }
}
struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(beacon: BeaconSetup.beacons[0])
            .previewDisplayName(BeaconSetup.beacons[0].roomName)
    }
}

