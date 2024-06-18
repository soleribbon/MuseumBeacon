//
//  Functions.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 01/05/24.
//

import SwiftUI

extension Font {
    static func avenirNext(size: CGFloat) -> Font {
        let metrics = UIFontMetrics(forTextStyle: .body)
        let customFont = UIFont(name: "Avenir Next", size: size)!
        let scaledFont = metrics.scaledFont(for: customFont)
        return Font(scaledFont)
    }
    
    static func avenirNextRegular(size: CGFloat) -> Font {
        let metrics = UIFontMetrics(forTextStyle: .body)
        let customFont = UIFont(name: "AvenirNext-Regular", size: size)!
        let scaledFont = metrics.scaledFont(for: customFont)
        return Font(scaledFont)
    }
}


//DELETE BELOW IF EVERYTHING IS GOOD WITH NEW BEACON IDs
//let loremIpsum = """
//This piece of fine art is renowned for its enigmatic expression which seems both alluring and aloof. Its delicacy lies in the masterful blending of light and shadow, creating soft transitions among the contours of the face.
//
//The background of the painting fades into a distant, dreamy landscape, adding to the ethereal quality of the work. The eyes of the subject, often described as the central feature of this artwork, follow the viewer with a gaze that appears to shift with the angle of view, suggesting a presence animated with intelligence and curiosity.
//
//The techniques employed in this piece were revolutionary for its time, introducing new methods of applying layers of paint to achieve a richness of tone and depth never before seen. The subtle gradation of colors and the detailed rendering of facial features indicate not only a technical prowess but also a deep understanding of human emotion and expression. This piece has been celebrated not only for its aesthetic qualities but also for its representation of universal themes such as identity, human nature, and the ambiguity of perception, which resonate with audiences across different cultures and eras.
//"""
//
//class ViewFrame: ObservableObject {
//    var startingRect: CGRect?
//
//    @Published var frame: CGRect {
//        willSet {
//            if startingRect == nil {
//                startingRect = newValue
//            }
//        }
//    }
//
//    init() {
//        self.frame = .zero
//    }
//}
//
//struct GeometryGetter: View {
//    @Binding var rect: CGRect
//
//    var body: some View {
//        GeometryReader { geometry in
//            AnyView(Color.clear)
//                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
//        }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
//            self.rect = value
//        }
//    }
//}
//
//struct RectanglePreferenceKey: PreferenceKey {
//    static var defaultValue: CGRect = .zero
//
//    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
//        value = nextValue()
//    }
//}
