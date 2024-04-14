//
//  GardenView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct GardenView: View {

    let pageNumber: Int
    @ObservedObject var gardenData: GardenData
    @State private var currentBackground = Background.daytime
    @State private var showModal1 = false
    @State private var showModal2 = false
    @State private var showModal3 = false

    var body: some View {
        ZStack {
            currentBackground.makeGradient()
                .ignoresSafeArea()

            StoneGrassView()
            FlowerView().position(CGPoint(x: 100, y: 550.0)) // left
            FlowerView().position(CGPoint(x: 300, y: 550.0)) // right
            CandleView().position(CGPoint(x: 200, y: 550.0))

            VStack {

                Spacer()

                Text("Page \(pageNumber + 1) Content")
                    .foregroundColor(.white)
                    .font(.custom("Marker Felt", size: 28))

                Spacer()

                VStack {
                    if gardenData.photoIds.isEmpty {
//                        var _ = print("isempty")
                        EmptySquareView()
                    } else {
                        // TODO: fetch images from cloud and render
//                        Image(uiImage: StorageHelper.getImageFromUserDefaults(key: gardenData.photoIds[currentIndex]))
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 200, height: 200)
//                            .cornerRadius(10)
//                            .onTapGesture {
//                                currentIndex = (currentIndex + 1) % gardenData.photoIds.count
//                                print("Showing image at index:", currentIndex, " of indices", gardenData.photoIds.count - 1)
//                            }
                    }

                            Text("Name: \(gardenData.name)")
                            Text("Birthdate: \(gardenData.bday, formatter: dateFormatter)")
                            Text("Date of Death: \(gardenData.dday, formatter: dateFormatter)")
                        }
                        .foregroundColor(.white)
                        .font(.custom("Marker Felt", size: 24))
                        .multilineTextAlignment(.center)

                Spacer()

                HStack {
                    Spacer()

                    Button(action: {
                        showModal1 = true
                    }) {
                        CircleButton(icon: "pencil")
                    }
                    .sheet(isPresented: $showModal1) {
                        EditorView(gardenData: gardenData, showModal: $showModal1)
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

                Spacer().frame(height: 70) // Adjust spacing as needed
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

struct EmptySquareView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: 200, height: 200)
            .cornerRadius(10)
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

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()

struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView(pageNumber: 1, gardenData: GardenData())
    }
}
