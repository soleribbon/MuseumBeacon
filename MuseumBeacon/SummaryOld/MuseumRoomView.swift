import SwiftUI

struct MuseumRoomView: View {
    var beacon: MuseumBeacon

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                GeometryReader { geometry in
                    let offset = getOffsetForHeaderImage(geometry)
                    let height = max(0, getHeightForHeaderImage(geometry))

                    Image(beacon.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: height)
                        .clipped()
                        .offset(y: offset)
                        .animation(.easeInOut, value: offset)
                }
                .frame(height: 300) // Setting the initial height for the header image

                Group {
                    Text(beacon.roomName)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 20)

                    Text(beacon.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.top, 5)

                    Text(beacon.dateRange)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.top, 5)
                }
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle(beacon.roomName)
        .navigationBarTitleDisplayMode(.inline)
    }

    // Calculate the offset for the header image based on the scroll
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        return min(0, offset)
    }

    // Adjust the height of the header image based on the scroll
    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getOffsetForHeaderImage(geometry)
        let height = geometry.size.height - offset
        return height
    }
}

// Preview for development usage
struct MuseumRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MuseumRoomView(beacon: MuseumBeacon(id: UUID(), identifier: "Beacon1", roomName: "Main Hall", imageName: "room1", description: "Explore this spacious area", dateRange: "2021 - Present"))
    }
}
