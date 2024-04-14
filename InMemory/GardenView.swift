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

            if gardenData.photoIds.isEmpty {
                EmptySquareView().position(CGPoint(x: 200.0, y: 260.0))
            } else {
                // Render images from cloud, look page bottom
            }

            VStack {
                Text("\(gardenData.name)")
                Text("\(gardenData.bday, formatter: dateFormatter)")
                Text("\(gardenData.dday, formatter: dateFormatter)")
            }
            .foregroundColor(.white)
            .font(.custom("Marker Felt", size: 22))
            .multilineTextAlignment(.center)
            .position(CGPoint(x: 200.0, y: 400.0))

            HStack {
               Spacer()
               ActionButton(icon: "pencil") {
                   showModal1 = true
               }
               .sheet(isPresented: $showModal1) {
                   EditorView(gardenData: gardenData, showModal: $showModal1, background: currentBackground)
               }
               Spacer()
               ActionButton(icon: "lightbulb") {
                   showModal2 = true
               }
               .sheet(isPresented: $showModal2) {
                   ResourcesView(background: currentBackground)
               }
               Spacer()
               ActionButton(icon: "note.text") {
                   showModal3 = true
               }
               .sheet(isPresented: $showModal3) {
                   JournalView(background: currentBackground)
               }
               Spacer()
           }.position(CGPoint(x: 200, y: 700.0))

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
