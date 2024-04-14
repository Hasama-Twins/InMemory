//
//  CloudView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/14/24.
//

import SwiftUI
private var leftX =  -(UIScreen.main.bounds.width / 2) - 250

struct CloudView: View {
    @State private var xOffset: CGFloat = leftX

    var body: some View {
        VStack {
            Spacer()
            Image("clouds")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .offset(x: xOffset, y: -300)
                .animation(Animation.linear(duration: 40).repeatForever(autoreverses: false)) // Adjust duration here
                .onAppear {
                    self.xOffset = UIScreen.main.bounds.width / 2 + 250
                }
            Spacer()
        }
    }
}

#Preview {
    CloudView()
}
