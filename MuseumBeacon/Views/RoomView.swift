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
    
    var body: some View {
        NavigationView {
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
                            Text(beacon.subtitle)
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
                        
                    }.padding(.bottom, 10)
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
                    })
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16.0)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
}
struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView(beacon: BeaconSetup.beacons[0])
            .previewDisplayName(BeaconSetup.beacons[0].roomName)
    }
}

