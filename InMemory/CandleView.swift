//
//  CandleView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct CandleView: View {
    @State private var candleOn = true

    var body: some View {
        ZStack {
            Image(candleOn ? "candleOn" : "candleOff") // Use ternary operator to toggle between images
                .resizable()
                .frame(width: 100, height: 150)

            if candleOn {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [Color.yellow.opacity(0.5), Color.clear]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 80
                        )
                    )
                    .frame(width: 150, height: 150)
                    .offset(x: 0, y: -10)
            }
        }
        .onTapGesture {
            // Toggle the candleOn state when the image is tapped
            candleOn.toggle()
        }
    }
}

struct CandleView_Previews: PreviewProvider {
    static var previews: some View {
        CandleView()
    }
}
