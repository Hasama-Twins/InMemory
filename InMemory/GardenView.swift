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
    @State private var showModal1 = false
    @State private var showModal2 = false
    @State private var showModal3 = false
    
    var body: some View {
        ZStack {
            currentBackground.makeGradient()
                .ignoresSafeArea()
            
            Text("Page \(pageNumber + 1) Content")
                .foregroundColor(.white)
                .font(.largeTitle)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showModal1 = true
                    }) {
                        CircleButton(icon: "pencil")
                    }
                    .sheet(isPresented: $showModal1) {
                        EditorView()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showModal2 = true
                    }) {
                        CircleButton(icon: "lightbulb")
                    }
                    .sheet(isPresented: $showModal2) {
                        ResourcesView()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showModal3 = true
                    }) {
                        CircleButton(icon: "note.text")
                    }
                    .sheet(isPresented: $showModal3) {
                        JournalView()
                    }
                    
                    Spacer()
                }
                
                Spacer().frame(height: 40) // Adjust spacing as needed
            }
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

struct CircleButton: View {
    var icon: String
    
    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: 60, height: 60)
            .overlay(
                Image(systemName: icon)
                    .foregroundColor(.white)
            )
    }
    
}

struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView(pageNumber: 1)
    }
}
