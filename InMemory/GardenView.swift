//
//  GardenView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct GardenView: View {
    let pageNumber: Int
    @State private var currentBackground = Background.daytime
    
    var body: some View {
        ZStack {
            currentBackground.makeGradient()
                .ignoresSafeArea()
            
            Text("Page \(pageNumber + 1) Content")
                .foregroundColor(.white)
                .font(.largeTitle)
            
        }.onTapGesture {
            // Change the background option when tapped
            switch currentBackground {
            case .daytime:
                currentBackground = .nighttime
            case .nighttime:
                currentBackground = .sunset
            case .sunset:
                currentBackground = .daytime
            }
        }
    }
}
