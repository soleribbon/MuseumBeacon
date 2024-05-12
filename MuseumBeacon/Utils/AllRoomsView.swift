//
//  AllRoomsView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 10/05/24.
//

import SwiftUI

import SwiftUI

struct AllRoomsView: View {

    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {

            HStack {
                Text("All Rooms")
                    .font(.avenirNext(size: 28))
                    .bold()
                    .foregroundStyle(Color("wfpBlue"))
                    .accessibilityLabel("List of all rooms")
                    .padding(.vertical)
                Spacer()
            }


            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {

                ForEach(BeaconSetup.beacons) { beacon in
                    ZStack {
                        Image(beacon.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black.opacity(0.5), lineWidth: 0.5)
                            )
                            .blur(radius: 2)
                            .accessibilityHidden(true)

                        Text(beacon.roomName)
                            .font(.avenirNext(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(6)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .accessibilityLabel(beacon.roomName)

                    }
                    .cornerRadius(10)
                    .clipped()
                    .aspectRatio(1, contentMode: .fit) // Ensure that the frame is square
                }
            }

        }
    }
}

// Preview for development convenience
struct AllRoomsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRoomsView()
    }
}

