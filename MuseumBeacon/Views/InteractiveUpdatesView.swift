//
//  InteractiveUpdatesView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 02/05/24.
//


import SwiftUI

struct InteractiveUpdatesView: View {
    @ObservedObject var detector = BeaconDetector.shared
    private let imageHeight: CGFloat = 300
    private let collapsedImageHeight: CGFloat = 75
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero
    
    var body: some View {
        VStack {
            contentView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .onAppear {
            //RAVI
            detector.startScanning()
        }
        .onDisappear {
            detector.stopScanning()
        }
    }
    
    private var contentView: some View {
        Group {
            
            if detector.proximityDescription == "Searching..." {
                SearchingView()
                //default
            } else if let beacon = detector.lastKnownBeacon {
                RoomView(beacon: beacon)
            } else {
                NoRoomsFoundView()
            }
        }
    }
    
    
}

struct SearchingView: View {
    @Environment(\.dismiss) var dismiss
    let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Image(systemName: "figure.walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color("wfpBlue"))
                    .opacity(0.5)
                ProgressView()
                    .controlSize(.large)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("wfpBlue")))
            }.accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            Text("Searching for beacons...")
                .font(.avenirNext(size: 18))
                .bold()
                .foregroundColor(Color("wfpBlue"))
                .padding()
                .accessibilityAddTraits(.isHeader)
            
            Spacer()
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
            }).padding()
            
        }.padding()
    }
}

struct NoRoomsFoundView: View {
    @Environment(\.dismiss) var dismiss
    let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    var body: some View {
        
        VStack {
            Spacer()
            Text("No rooms found")
                .font(.avenirNext(size: 30))
                .bold()
                .foregroundColor(Color("wfpBlue"))
                .opacity(0.5)
                .accessibilityLabel("No rooms found")
                .accessibilityHint("No beacons are detected nearby.")
            Text("Please try again in a different area")
                .font(.avenirNext(size: 18))
                .foregroundColor(Color("wfpBlue"))
                .opacity(0.5)
                .accessibilityLabel("Please try again in a different area")
                .accessibilityHint("Try again in a different area.")
            Spacer()
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
            }).padding()
            
        }.padding()
        
    }
}



struct InteractiveUpdatesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InteractiveUpdatesView(detector: BeaconDetectorMock.searching)
                .previewDisplayName("Searching")
            
            InteractiveUpdatesView(detector: BeaconDetectorMock.found)
                .previewDisplayName("Room Found")
            
            InteractiveUpdatesView(detector: BeaconDetectorMock.notFound)
                .previewDisplayName("No Rooms Found")
        }
    }
}

// Mock BeaconDetector for Preview
class BeaconDetectorMock: BeaconDetector {
    static let searching: BeaconDetectorMock = {
        let mock = BeaconDetectorMock()
        mock.proximityDescription = "Searching..."
        return mock
    }()
    
    static let found: BeaconDetectorMock = {
        let mock = BeaconDetectorMock()
        mock.proximityDescription = "Found"
        mock.lastKnownBeacon = MuseumBeacon(
            id: UUID(uuidString: "FDA50693-A4E2-4FB1-AFCF-C6EB07647822")!,
            identifier: "Beacon1",
            roomName: "Main Lobby",
            imageName: "entrance",
            description: "Welcome to the Headquarters of the World Food Programme.",
            moreInformation: "This area serves as the primary.",
            subtitle: "Entrance Area",
            nearbyRooms: [
                "Reception": "SOUTH",
                "Corridors": "WEST",
                "Nobel": "NORTHWEST",
                "Exit": "NORTHEAST"
            ]
        )
        return mock
    }()
    
    static let notFound: BeaconDetectorMock = {
        let mock = BeaconDetectorMock()
        mock.proximityDescription = "Not Found"
        return mock
    }()
}
