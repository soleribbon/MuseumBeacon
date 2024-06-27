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
                headerView
                    .padding([.top, .horizontal])
                Image("allWorld")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .accessibilityHidden(true)
                
                List {
                    Section(header: Text("Welcome")
                        .font(.avenirNext(size: 24))
                        .bold()
                        .foregroundStyle(Color(red: 0.471, green: 0.475, blue: 0.529))
                            
                    ) {
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
                                    .padding(.leading, 10)
                                VStack(alignment: .leading) {
                                    Text("Automatic Guide Mode")
                                        .font(.avenirNext(size: 18))
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color("wfpBlack"))
                                        .accessibilityAddTraits(.isHeader)
                                    
                                    Text("Points of interest are read out-loud, completely hands-free. Just start walking!")
                                        .font(.avenirNext(size: 14))
                                        .foregroundStyle(.gray)
                                }.padding()
                                
                            }
                        }
                    }
                    .headerProminence(.increased)
                    
                    Section {
                        NavigationLink(destination: AllRoomsView(source: "MainStartView")) {
                            HStack {
                                Image(systemName: "point.3.filled.connected.trianglepath.dotted")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(Color("wfpBlue"))
                                    .padding(.leading, 10)
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
                                    .padding(.leading, 10)
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
                    Section {
                        Text("Beta v0.65")
                            .font(.avenirNext(size: 12))
                            .foregroundStyle(.gray)
                            .accessibilityHidden(true)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .listRowBackground(Color.clear)
                    
                }
                .listStyle(.insetGrouped)
                .environment(\.horizontalSizeClass, .regular)
                .navigationBarTitleDisplayMode(.inline)
                
            }
            
            .fullScreenCover(isPresented: $showInteractiveUpdates, content: InteractiveUpdatesView.init)
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Image("WFPLogo")
                .resizable()
                .frame(width: 60, height: 60)
                .accessibilityHidden(true)
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
            }.padding()
        }
    }
}


struct MainStartView_Previews: PreviewProvider {
    static var previews: some View {
        MainStartView()
    }
}


