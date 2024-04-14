//
//  ContentView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfPages = 0
    @State private var currentPage = 0
    @State private var pins: [String] = []

    var body: some View {
        ZStack {
            Background.daytime.makeGradient()
                .ignoresSafeArea()

            TabView(selection: $currentPage) {
                if numberOfPages == 0 {
                    NewGardenView(numberOfPages: $numberOfPages, currentPage: $currentPage, pins: $pins)
                } else {
                    ForEach(0..<numberOfPages, id: \.self) { index in
                        if index == (numberOfPages - 1) {
                            NewGardenView(numberOfPages: $numberOfPages, currentPage: $currentPage, pins: $pins)
                                .tag(index)
                        } else {
                            GardenView(pageNumber: index, memorialPin: pins[index])
                                .tag(index)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
