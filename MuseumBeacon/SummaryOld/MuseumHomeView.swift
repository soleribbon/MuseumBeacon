import SwiftUI
import ScrollViewReactiveHeader

struct MuseumHomeView: View {
    @ObservedObject var detector = BeaconDetector.shared
    @State private var showingProfile = false

    var body: some View {
        NavigationSplitView {
            ScrollView {
                VStack {
                    if let lastKnownBeacon = detector.lastKnownBeacon {
                        NavigationLink(destination: MuseumRoomView(beacon: lastKnownBeacon)) {
                            featuredBeaconView(beacon: lastKnownBeacon)
                        }
                    } else {
                        Image("museum")
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 200)
                            .clipped()
                    }

                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible())], spacing: 0) {
                        ForEach(BeaconSetup.beacons) { beacon in
                            NavigationLink(destination: MuseumRoomView(beacon: beacon)) {
                                beaconThumbnailView(beacon: beacon)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("All Exhibitions")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                Text("Profile")
            }
        } detail: {
            Text("Select a Landmark")
        }
    }

    private func featuredBeaconView(beacon: MuseumBeacon) -> some View {
        Image(beacon.imageName)
            .resizable()
            .scaledToFill()
            .clipped()
    }

    private func beaconThumbnailView(beacon: MuseumBeacon) -> some View {
        VStack(alignment: .center) {

            Image(beacon.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
                .shadow(radius: 2)

            Text(beacon.roomName)
                .font(.headline)
                .foregroundColor(.primary)
            Text(beacon.dateRange.uppercased())
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
    }
}





// Preview for development usage
struct MuseumHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MuseumHomeView()
    }
}
