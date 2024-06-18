//
//  FullFloorMapView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 12/06/24.
//

import SwiftUI

struct FullFloorMapView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        VStack {
            headerView
                .padding(.horizontal)
                .padding(.top)
            ZoomableScrollView {
                Image("fullFloorMap")
                    .resizable()
                    .scaledToFit()
                    .background(.white)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        
    }
    
    
    private var headerView: some View {
        HStack {
            Text("Level 1 Map | HQ")
                .font(.avenirNext(size: 28))
                .bold()
                .foregroundStyle(Color("wfpBlue"))
                .accessibilityLabel("Image of Level 1 Map")
                .padding(.vertical)
            Spacer()
        }
    }
    
    private var backButton : some View { Button(action: {
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

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}

struct FullFloorMapView_Previews: PreviewProvider {
    static var previews: some View {
        FullFloorMapView()
    }
}
