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

    var body: some View {
        ScrollView {
            Image(beacon.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipped()
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 2)
                .ignoresSafeArea(edges: .top)
                .accessibilityHidden(true)
            
            VStack (alignment: .leading, spacing: 20){
                VStack (alignment: .leading, spacing: 8){
                    VStack (alignment: .leading, spacing: 0){
                        Text(beacon.artist)
                            .font(.avenirNextRegular(size: 16))
                            .foregroundColor(.gray)
                            .accessibilityAddTraits(.isHeader)

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

                }
               

                Text(loremIpsum)
                    .lineLimit(nil)
                    .font(.avenirNextRegular(size: 18))
                    .foregroundStyle(Color("wfpBlack"))
                    .lineSpacing(4)
                    .accessibilityAddTraits(.isHeader)


                AllRoomsView()
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 16.0)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

