import SwiftUI

struct ContentView: View {
    @ObservedObject var detector = BeaconDetector()

    var body: some View {
        VStack {
            switch detector.proximityDescription {
            case "Searching...":
                searchingView
            default:
                detectedRoomView
            }
        }
        .padding()
        .animation(.easeInOut, value: detector.proximityDescription)
    }

    private var searchingView: some View {
        VStack {
            Spacer()

            Text("Searching for beacons...")
                .font(.title)
                .foregroundColor(.gray)
                .padding()
            ProgressView()
                .controlSize(.large)
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
            Spacer()
        }
    }

    private var detectedRoomView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Detected Room")
                .font(.headline)
                .foregroundColor(.secondary)
            Text(detector.proximityDescription)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(determineColorBasedOnProximity())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.95))
        .cornerRadius(12)
        .shadow(radius: 10)
    }

    private func determineColorBasedOnProximity() -> Color {
        switch detector.proximityDescription {
        case let description where description.contains("Very close"):
            return .green
        case let description where description.contains("Near"):
            return .orange
        case let description where description.contains("Far"):
            return .red
        default:
            return .black
        }
    }
}
