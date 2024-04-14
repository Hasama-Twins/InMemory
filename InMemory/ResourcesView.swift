//
//  ResourcesView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct ResourcesView: View {
    var background: Background // Accepts a Background enum

    var body: some View {
        ZStack {
            background.makeGradient() // Apply the background gradient based on the enum

            Text("Resources View")
                .foregroundColor(.white)
                .font(.title)
        }
        .ignoresSafeArea()
    }
}

// Preview
struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView(background: .daytime) // Example usage with daytime background
    }
}
