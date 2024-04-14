//
//  CandleView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct CandleView: View {
    @Binding private var candleOn: Bool
    var documentId: String

    // Explicit initializer to initialize the @Binding property
    init(candleOn: Binding<Bool>, documentId: String) {
        self._candleOn = candleOn
        self.documentId = documentId
    }

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
            FirebaseHelper.updateCandle(documentId: documentId, candleOn: candleOn) { error in
                if error != nil {
                    candleOn.toggle()
                }
            }
        }
    }
}

struct CandleView_Previews: PreviewProvider {
    static var previews: some View {
        let isCandleOn = Binding<Bool>(
            get: { true }, // Sample value
            set: { _ in }
        )
        return CandleView(candleOn: isCandleOn, documentId: "")
    }
}
