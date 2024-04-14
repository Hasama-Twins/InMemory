//
//  ContentView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cloudOffset: CGFloat = -UIScreen.main.bounds.width / 2 - 200
    @State private var numberOfPages = 1
    @State private var currentPage = 0
    @State private var pins: [String] = []
    @State private var currentBackground = Background.daytime

    var body: some View {

        ZStack {
            currentBackground.makeGradient()
                .ignoresSafeArea()

            CloudView()

            TabView(selection: $currentPage) {
                if numberOfPages == 1 {
                    NewGardenView(numberOfPages: $numberOfPages, currentPage: $currentPage, pins: $pins)
                } else {
                    ForEach(0..<numberOfPages, id: \.self) { index in
                        if index == (numberOfPages - 1) {
                            NewGardenView(numberOfPages: $numberOfPages, currentPage: $currentPage, pins: $pins)
                                .tag(index)
                        } else {
                            GardenView(pageNumber: index, memorialPin: pins[index], currentBackground: currentBackground)
                                .tag(index)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .ignoresSafeArea()

            Rectangle()
            .fill(Color.white)
            .opacity(0.0001)
            .frame(height: UIScreen.main.bounds.height / 2 + 10)
            .position(CGPoint(x: 195.0, y: 70.0))
            .onTapGesture {
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

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
