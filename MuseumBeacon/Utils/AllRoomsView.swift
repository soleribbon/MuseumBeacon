import SwiftUI

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
                    .aspectRatio(1, contentMode: .fit)
                    .onTapGesture {

                        impactMed.impactOccurred()
                        selectedBeacon = beacon
                    }
                }
            }
        }
        .sheet(item: $selectedBeacon) { beacon in
            RoomDetailView(beacon: beacon)
        }
    }
}


struct RoomDetailView: View {
    let beacon: MuseumBeacon
    @Environment(\.presentationMode) var presentationMode
    let impactMed = UIImpactFeedbackGenerator(style: .rigid)
    var body: some View {
        VStack(spacing: 20) {
            Image(beacon.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 10)

            Text(beacon.roomName)
                .font(.avenirNext(size: 24))
                .bold()
                .foregroundStyle(Color("wfpBlue"))

            Text(beacon.artist)
                .font(.avenirNextRegular(size: 20))
                .foregroundColor(.gray)

            Text(beacon.description)
                .font(.avenirNextRegular(size: 18))
                .foregroundColor(Color("wfpBlack"))
                .lineSpacing(4)
                .padding()

            Spacer()
            Button(action: {

                impactMed.impactOccurred()
                           presentationMode.wrappedValue.dismiss()
                       }) {
                           Text("Close")
                               .font(.avenirNext(size: 18))
                               .padding()
                               .background(Color("wfpBlue"))
                               .foregroundColor(.white)
                               .cornerRadius(10)
                       }
        }
        .padding()
    }
}

struct AllRoomsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRoomsView()
    }
}
