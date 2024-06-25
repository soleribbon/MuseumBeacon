import SwiftUI
import UIKit

struct AllRoomsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible())
    ]
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    let source: String
    
    var body: some View {
        VStack {
            ScrollView {
                headerView
                beaconGrid
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
        
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
                NavigationLink(destination: RoomDetailView(beacon: beacon, source: source)) {
                    beaconItem(beacon)
                    
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
    
    var backButton: some View {
        Button(action: {
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
    let source: String
    @Environment(\.presentationMode) var presentationMode
    let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    @State private var showInteractiveUpdates = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerImage
                .frame(maxWidth: .infinity)
            ScrollView {
                content
            }
            if source == "MainStartView" {
                startGuideButton
            }
        }
        .padding()
        .fullScreenCover(isPresented: $showInteractiveUpdates, content: InteractiveUpdatesView.init)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .accessibilityHidden(true)
                    .font(.avenirNext(size: 18))
                    .bold()
                    .foregroundStyle(Color("wfpBlue"))
                    .accessibilityLabel("Go back to All Points of Interest")
                    .padding(.vertical)
                
                Text("Back")
                    .font(.avenirNext(size: 18))
                    .bold()
                    .foregroundStyle(Color("wfpBlue"))
                    .accessibilityLabel("Go back to All Points of Interest")
                    .padding(.vertical)
            }
            .accessibilityElement(children: .combine)
        }
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
            VStack(alignment: .leading, spacing: 0) {
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
    
    private var startGuideButton: some View {
        Button(action: {
            impactRigid.impactOccurred()
            showInteractiveUpdates = true
        }) {
            Text("Start Guide Mode")
                .font(.avenirNext(size: 18))
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("wfpBlue"))
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
                .accessibilityLabel("Start Guide Mode")
        }
        .padding(.horizontal, 24)
        .padding(.top, 16.0)
    }
}
struct AllRoomsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRoomsView(source: "MainStartView")
    }
}
