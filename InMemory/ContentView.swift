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
    
    var body: some View {
        ZStack {
            Color.blue
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


