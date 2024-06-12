//
//  MainStartView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 12/06/24.
//

import SwiftUI

struct MainStartView: View {
    @State private var showInteractiveUpdates = false
    let impactMed = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Image("WFPLogo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.trailing, 10)
                    VStack(alignment: .leading) {
                        Text("World Food Programme")
                            .font(.avenirNextRegular(size: 16))
                            .foregroundStyle(Color("wfpBlue"))
                            .accessibilityAddTraits(.isHeader)
                        Text("Rome HQ Guide")
                            .font(.avenirNext(size: 28))
                            .bold()
                            .foregroundStyle(Color("wfpBlue"))
                            .accessibilityAddTraits(.isHeader)
                    }
                }
                .padding()

                List {
                    Section(header: Text("Welcome!").foregroundStyle(.gray)) {
                        Button(action: {
                            impactMed.impactOccurred()
                            showInteractiveUpdates = true
                        }) {
                            HStack {
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color("wfpBlue"))

                                VStack(alignment: .leading) {
                                    Text("Automatic Guide Mode")
                                        .font(.avenirNext(size: 18))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color("wfpBlack"))
                                        .accessibilityAddTraits(.isHeader)

                                    Text("Points of interest are read out-loud, completely hands-free. Just start walking!")
                                        .font(.avenirNext(size: 14))
                                        .foregroundStyle(.gray)
                                }
                                .padding()
                            }
                        }
                    }
                    .headerProminence(.increased)

                    Section {
                        NavigationLink(destination: AllRoomsView()) {
                            HStack {
                                Image(systemName: "point.3.filled.connected.trianglepath.dotted")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color("wfpBlue"))
                                VStack(alignment: .leading) {
                                    Text("All Points of Interest")
                                        .font(.avenirNext(size: 18))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color("wfpBlack"))
                                        .accessibilityAddTraits(.isHeader)
                                    Text("General information about all discoverable places inside the WFP headquarters.")
                                        .font(.avenirNext(size: 14))
                                        .foregroundStyle(.gray)
                                }
                                .padding()
                            }
                        }

                        NavigationLink(destination: FullFloorMapView()) {
                            HStack {
                                Image(systemName: "map.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color("wfpBlue"))
                                VStack(alignment: .leading) {
                                    Text("Full Floor Map")
                                        .font(.avenirNext(size: 18))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color("wfpBlack"))
                                        .accessibilityAddTraits(.isHeader)
                                    Text("Let the detailed floor plan guide you in understanding the layout of the first level.")
                                        .font(.avenirNext(size: 14))
                                        .foregroundStyle(.gray)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .environment(\.horizontalSizeClass, .regular)
                .navigationBarTitleDisplayMode(.inline)
            }

            .fullScreenCover(isPresented: $showInteractiveUpdates, content: InteractiveUpdatesView.init)
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
}


struct MainStartView_Previews: PreviewProvider {
    static var previews: some View {
        MainStartView()
    }
}


