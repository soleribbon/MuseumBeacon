//
//  SuggestedPathView.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 19/06/24.
//

import SwiftUI

struct SuggestedPathView: View {
    let destination: String
    let steps: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("To \(destination)")
                .font(.avenirNextRegular(size: 16))
                .foregroundColor(.gray)
                .bold()
            VStack(alignment: .leading, spacing: 0) {
                ForEach(steps, id: \.self) { step in
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                            .foregroundColor(Color("wfpBlue"))
                            .opacity(0.5)
                            .bold()
                        Text(step)
                            .font(.avenirNextRegular(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 2)
                    if step != steps.last {
                        VStack(spacing: 0) {
                            ForEach(0..<2) { _ in
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 3))
                                    .foregroundColor(Color("wfpBlue"))
                                    .opacity(0.5)
                                    .padding(.leading, 3)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 4)

        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(suggestedPathAccessibilityLabel())
    }

    private func suggestedPathAccessibilityLabel() -> String {
        var label = "Path to \(destination): Go to the "
        for step in steps {
            label += "\(step), then to "
        }
        label.removeLast(6) // Remove trailing ", then "
        return label
    }
}



extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map { startIndex in
            Array(self[startIndex..<Swift.min(startIndex + size, count)])
        }
    }
}

struct SuggestedPathView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestedPathView(destination: "Auditorium", steps: ["Your Position", "Corridors Junction", "Auditorium Corridor"])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
