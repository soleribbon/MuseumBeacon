import SwiftUI

struct ContentView: View {
    @ObservedObject var detector = BeaconDetector.shared

    private let imageHeight: CGFloat = 300
    private let collapsedImageHeight: CGFloat = 75

    @ObservedObject private var articleContent: ViewFrame = ViewFrame()
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero


    var body: some View {
        VStack {
            if detector.proximityDescription == "Searching..." {
                searchingView
            } else if let beacon = detector.lastKnownBeacon {
                //                roomView(beacon: beacon)
                MuseumHomeView()
            } else {
                Text("No rooms found")
                    .font(.title)
                    .foregroundColor(.gray)
            }
        }
        .alert(isPresented: $detector.showAlert) {
            Alert(
                title: Text("Switch Rooms?"),
                message: Text("Would you like to move to the \(detector.potentialNewBeacon?.roomName ?? "next room")?"),
                primaryButton: .default(Text("Confirm")) {
                    detector.confirmRoomChange()
                },
                secondaryButton: .cancel()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.95))
        .ignoresSafeArea()

    }

    func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }

    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight


        if offset < -sizeOffScreen {

            let imageOffset = abs(min(-sizeOffScreen, offset))


            return imageOffset - sizeOffScreen
        }

        // Image was pulled down
        if offset > 0 {
            return -offset

        }

        return 0
    }

    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height

        if offset > 0 {
            return imageHeight + offset
        }

        return imageHeight
    }

    // at 0 offset our blur will be 0
    // at 300 offset our blur will be 6
    func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY

        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height

        return blur * 6
    }


    private func getHeaderTitleOffset() -> CGFloat {
        let currentYPos = titleRect.midY


        if currentYPos < headerImageRect.maxY {
            let minYValue: CGFloat = 50.0
            let maxYValue: CGFloat = collapsedImageHeight
            let currentYValue = currentYPos

            let percentage = max(-1, (currentYValue - maxYValue) / (maxYValue - minYValue))
            let finalOffset: CGFloat = -30.0

            return 20 - (percentage * finalOffset)
        }

        return .infinity
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

    func roomView(beacon: MuseumBeacon) -> some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 10) {

                    Text(beacon.dateRange)
                        .font(.avenirNextRegular(size: 12))
                        .foregroundColor(.gray)

                    Text(beacon.roomName)
                        .font(.avenirNext(size: 28))
                        .bold()
                        .foregroundStyle(Color("wfpBlue"))
                        .background(GeometryGetter(rect: self.$titleRect))

                    Text(loremIpsum)
                        .lineLimit(nil)
                        .font(.avenirNextRegular(size: 17))
                        .foregroundStyle(Color("wfpBlack"))

                }
                .padding(.horizontal)
                .padding(.top, 16.0)
            }
            .offset(y: imageHeight + 16)
            .background(GeometryGetter(rect: $articleContent.frame))

            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    Image(beacon.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
                        .blur(radius: self.getBlurRadiusForImage(geometry))
                        .clipped()
                        .background(GeometryGetter(rect: self.$headerImageRect))

                    Text(beacon.roomName)
                        .font(.avenirNext(size: 24))
                        .bold()
                        .foregroundStyle(Color(.white))
                        .offset(x: 0, y: self.getHeaderTitleOffset()+10)
                }
                .clipped()
                .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
            }.frame(height: imageHeight)
                .offset(x: 0, y: -(articleContent.startingRect?.maxY ?? UIScreen.main.bounds.height))
        }.edgesIgnoringSafeArea(.all)
    }
}
