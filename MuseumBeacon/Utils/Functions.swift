//
//  Test2.swift
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


let loremIpsum = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vel risus commodo viverra maecenas accumsan lacus vel facilisis volutpat. Vestibulum rhoncus est pellentesque elit. Eget nunc lobortis mattis aliquam faucibus purus in massa tempor. Mattis vulputate enim nulla aliquet. Ac placerat vestibulum lectus mauris ultrices eros in. Suspendisse sed nisi lacus sed viverra tellus in. Ullamcorper eget nulla facilisi etiam. Leo a diam sollicitudin tempor id. Sollicitudin nibh sit amet commodo nulla facilisi.

In nisl nisi scelerisque eu ultrices. Et leo duis ut diam quam nulla porttitor massa. Tempor orci eu lobortis elementum nibh tellus molestie nunc. Vitae elementum curabitur vitae nunc sed. Sit amet aliquam id diam maecenas ultricies mi eget mauris. Ut tristique et egestas quis ipsum suspendisse. Ultricies integer quis auctor elit sed vulputate mi sit. Tincidunt id aliquet risus feugiat in ante. Amet tellus cras adipiscing enim eu turpis. Sit amet purus gravida quis blandit. Vulputate ut pharetra sit amet aliquam. Consequat nisl vel pretium lectus quam id leo. Libero id faucibus nisl tincidunt eget.

Imperdiet massa tincidunt nunc pulvinar sapien. Urna porttitor rhoncus dolor purus non enim praesent elementum. Elit eget gravida cum sociis natoque penatibus et magnis dis. Viverra nibh cras pulvinar mattis nunc. Neque vitae tempus quam pellentesque nec nam. Scelerisque purus semper eget duis at tellus at urna condimentum. Fringilla ut morbi tincidunt augue interdum. Pretium lectus quam id leo in. Nibh tellus molestie nunc non blandit. Orci nulla pellentesque dignissim enim sit amet venenatis. Amet consectetur adipiscing elit ut aliquam purus sit. Ut ornare lectus sit amet est placerat in. Fames ac turpis egestas sed tempus urna et pharetra pharetra. Nec feugiat in fermentum posuere urna. At imperdiet dui accumsan sit amet nulla facilisi. Neque volutpat ac tincidunt vitae. Faucibus nisl tincidunt eget nullam non nisi est. Id diam vel quam elementum pulvinar etiam non quam.

Nunc faucibus a pellentesque sit amet porttitor. Vitae purus faucibus ornare suspendisse sed nisi. Vitae et leo duis ut diam quam nulla porttitor. Diam ut venenatis tellus in metus vulputate eu scelerisque. Ut diam quam nulla porttitor massa. In mollis nunc sed id semper risus in. Odio facilisis mauris sit amet massa. Ultricies lacus sed turpis tincidunt id aliquet risus feugiat in. Augue eget arcu dictum varius duis at consectetur lorem donec. Nullam ac tortor vitae purus faucibus ornare suspendisse sed nisi. Cursus euismod quis viverra nibh cras pulvinar. Aliquam eleifend mi in nulla. Ultrices neque ornare aenean euismod elementum nisi quis. Tristique senectus et netus et malesuada fames ac. Urna nec tincidunt praesent semper feugiat.

Egestas congue quisque egestas diam in arcu cursus euismod. Mattis aliquam faucibus purus in massa tempor nec. Sapien faucibus et molestie ac. Eu feugiat pretium nibh ipsum consequat nisl vel pretium. Dolor morbi non arcu risus quis. Mattis nunc sed blandit libero volutpat sed. Fermentum dui faucibus in ornare. Nam at lectus urna duis convallis convallis tellus id. Ipsum suspendisse ultrices gravida dictum fusce. Vestibulum lorem sed risus ultricies tristique. Sociis natoque penatibus et magnis dis parturient montes. Maecenas pharetra convallis posuere morbi leo. Aliquam sem et tortor consequat id porta nibh venenatis cras. Hendrerit dolor magna eget est lorem. Ac turpis egestas sed tempus.

Facilisis leo vel fringilla est ullamcorper eget nulla. Porttitor rhoncus dolor purus non enim praesent elementum. Nunc faucibus a pellentesque sit amet porttitor. Tincidunt praesent semper feugiat nibh. Nec nam aliquam sem et tortor consequat id porta. Eu consequat ac felis donec et odio. Id faucibus nisl tincidunt eget nullam non nisi est. Sit amet volutpat consequat mauris nunc congue. Proin sed libero enim sed. Sagittis orci a scelerisque purus semper eget duis at. Urna molestie at elementum eu. A lacus vestibulum sed arcu non. Ut enim blandit volutpat maecenas volutpat. Libero justo laoreet sit amet. Aliquam vestibulum morbi blandit cursus risus at.
"""

class ViewFrame: ObservableObject {
    var startingRect: CGRect?

    @Published var frame: CGRect {
        willSet {
            if startingRect == nil {
                startingRect = newValue
            }
        }
    }

    init() {
        self.frame = .zero
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            AnyView(Color.clear)
                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
        }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
            self.rect = value
        }
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
