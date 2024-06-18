//  DirectionArrow.swift
//  MuseumBeacon
//
//  Created by Ravi Heyne on 18/06/24.
//

import SwiftUI

struct DirectionArrow: View {
    var directionDegrees: Double
    @State private var currentDegrees: Double = 0
    
    var body: some View {
        Image(systemName: "arrowshape.up.circle.fill")
            .resizable()
            .frame(width: 24, height: 24)
            .rotationEffect(.degrees(currentDegrees))
            .onAppear {
                withAnimation(.linear(duration: 0.3)) {
                    currentDegrees = directionDegrees
                }
            }
            .onChange(of: directionDegrees) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    currentDegrees = directionDegrees
                }
            }
    }
}
