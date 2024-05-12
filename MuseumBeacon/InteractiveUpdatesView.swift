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
        .alert(isPresented: $detector.showAlert, content: roomChangeAlert)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.95))
        .ignoresSafeArea()
    }
    
    private var contentView: some View {
        Group {
            if detector.proximityDescription == "Searching..." {
                SearchingView()
            } else if let beacon = detector.lastKnownBeacon {
                RoomView(beacon: beacon)
            } else {
                NoRoomsFoundView()
            }
        }
    }
    
    private func roomChangeAlert() -> Alert {
        Alert(
            title: Text("Switch Rooms?"),
            message: Text("Would you like to move to the \(detector.potentialNewBeacon?.roomName ?? "next room")?"),
            primaryButton: .default(Text("Confirm"), action: detector.confirmRoomChange),
            secondaryButton: .cancel()
        )
    }
}

struct SearchingView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Searching for beacons...")
                .font(.system(size: 17, weight: .regular, design: .default))
                .foregroundColor(.gray)
                .padding()
            ProgressView()
                .controlSize(.large)
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
            Spacer()
        }
    }
}

struct NoRoomsFoundView: View {
    var body: some View {
        Text("No rooms found")
            .font(.title)
            .foregroundColor(.gray)
            .accessibilityLabel("No rooms found")
            .accessibilityHint("No beacons are detected nearby.")
    }
}



