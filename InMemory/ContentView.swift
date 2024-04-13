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
    @State private var currentBackground = Background.nighttime
    
    var body: some View {
        ZStack {
            currentBackground.makeGradient()
                .ignoresSafeArea()
            
            TabView(selection: $currentPage) {
                if numberOfPages == 0 {
                    NewGardenView(numberOfPages: $numberOfPages, currentPage: $currentPage)
                } else {
                    ForEach(0..<numberOfPages, id: \.self) { index in
                        
                        if index == (numberOfPages - 1) {
                            NewGardenView(numberOfPages: $numberOfPages, currentPage: $currentPage)
                        } else {
                            GardenView(pageNumber: index)
                                .tag(index)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .ignoresSafeArea()
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


