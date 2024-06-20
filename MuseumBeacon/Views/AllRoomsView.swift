import SwiftUI
import UIKit

struct AllRoomsView: View {
    @State private var selectedBeacon: MuseumBeacon? = nil
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible())
    ]
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        ScrollView {
            headerView
            beaconGrid
        }
        .padding()
        .sheet(item: $selectedBeacon) { beacon in
            RoomDetailView(beacon: beacon)                .accessibilityAddTraits(.isModal)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var headerView: some View {
        HStack {
            Text("All Points of Interest")
                .font(.avenirNext(size: 28))
                .bold()
                .foregroundStyle(Color("wfpBlue"))
                .accessibilityLabel("Below is a list of all points of interest. Select one to get more information.")
                .padding(.vertical)
            Spacer()
        }
    }
    
    private var beaconGrid: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            ForEach(BeaconSetup.beacons) { beacon in
                beaconItem(beacon)
                    .onTapGesture {
                        impactMed.impactOccurred()
                        selectedBeacon = beacon
                    }
            }
        }
    }
    
    private func beaconItem(_ beacon: MuseumBeacon) -> some View {
        ZStack {
            Image(beacon.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
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
        .aspectRatio(1, contentMode: .fit)
    }
    
    private var backButton : some View { Button(action: {
        presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left")
                .accessibilityHidden(true)
                .font(.avenirNext(size: 18))
                .bold()
                .foregroundStyle(Color("wfpBlue"))
                .accessibilityLabel("Go back to the main page")
                .padding(.vertical)
            
            Text("Back")
                .font(.avenirNext(size: 18))
                .bold()
                .foregroundStyle(Color("wfpBlue"))
                .accessibilityLabel("Go back to the main page")
                .padding(.vertical)
        }
        .accessibilityElement(children: .combine)
    }
    }
}

struct RoomDetailView: View {
    let beacon: MuseumBeacon
    @Environment(\.presentationMode) var presentationMode
    let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerImage
                .frame(maxWidth: .infinity)
            ScrollView {
                content
            }
            closeButton
        }
        .padding()
    }
    
    private var headerImage: some View {
        Image(beacon.imageName)
            .resizable()
            .scaledToFill()
            .clipped()
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
            .accessibilityHidden(true)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack (alignment: .leading, spacing: 0) {
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
                .font(.avenirNextRegular(size: 18))
                .fontWeight(.semibold)
                .foregroundStyle(Color("wfpBlack"))
                .lineSpacing(4)
                .accessibilityAddTraits(.isHeader)
                .padding(.bottom, 20)
            
            
            if let moreInformation = beacon.moreInformation, !moreInformation.isEmpty {
                Text("MORE INFORMATION")
                    .font(.avenirNextRegular(size: 18))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("wfpBlue"))
                    .accessibilityAddTraits(.isHeader)
                
                Text(moreInformation)
                    .font(.avenirNextRegular(size: 18))
                    .foregroundStyle(Color("wfpBlack"))
                    .lineSpacing(4)
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 16.0)
    }
    
    private var closeButton: some View {
        Button(action: {
            impactRigid.impactOccurred()
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Close")
                .font(.avenirNext(size: 18))
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("wfpBlue"))
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                .accessibilityLabel("Close Point of Interest Information Modal")
        }
        .padding(.horizontal, 24)
        .padding(.top, 16.0)
    }
}

struct AllRoomsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRoomsView()
    }
}
