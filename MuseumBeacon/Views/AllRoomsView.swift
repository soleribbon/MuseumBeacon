import SwiftUI
import UIKit

struct AllRoomsView: View {
    @State private var selectedBeacon: MuseumBeacon? = nil
    
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
            RoomDetailView(beacon: beacon)
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("All Rooms")
                .font(.avenirNext(size: 28))
                .bold()
                .foregroundStyle(Color("wfpBlue"))
                .accessibilityLabel("List of all rooms")
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
}

struct RoomDetailView: View {
    let beacon: MuseumBeacon
    @Environment(\.presentationMode) var presentationMode
    let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerImage
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
            .scaledToFit()
            .frame(height: 200)
            .clipped()
            .cornerRadius(10)
            .padding(.bottom)
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
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("wfpBlue"))
                .foregroundColor(.white)
                .cornerRadius(10)
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
