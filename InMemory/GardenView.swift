//
//  GardenView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI
import Firebase

struct GardenView: View {

    let pageNumber: Int
    var memorialPin: String
    let currentBackground: Background
    @ObservedObject var gardenDataFetcher = GardenDataFetcher()
    @State private var showModal1 = false
    @State private var showModal2 = false
    @State private var showModal3 = false
    @State private var loadedImage: UIImage?

    var body: some View {
        ZStack {

            StoneGrassView()
            FlowerView().position(CGPoint(x: 100, y: 550.0)) // left
            FlowerView().position(CGPoint(x: 300, y: 550.0)) // right
            CandleView().position(CGPoint(x: 200, y: 550.0))

            if (gardenDataFetcher.gardenData == nil) || gardenDataFetcher.gardenData!.photoIds.isEmpty {
                EmptySquareView().position(CGPoint(x: 200.0, y: 260.0))
            } else {
                    if let image = loadedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .cornerRadius(10)
                    } else {
                        ProgressView() // Placeholder while loading
                            .frame(width: 200, height: 200)
                            .onAppear {
                                ImageFirebaseHelper.getPhotoFromPath(path: gardenDataFetcher.gardenData?.photoIds[0] ?? "") { image in
                                    if let image = image {
                                        self.loadedImage = image
                                    }
                                }
                            }
                    }
            }

            VStack {
                Text(gardenDataFetcher.gardenData?.name ?? "Unknown Name")
                Text(GardenData.formattedDate(date: gardenDataFetcher.gardenData?.bday ?? Date()))
                Text(GardenData.formattedDate(date: gardenDataFetcher.gardenData?.dday ?? Date()))
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
                   EditorView(gardenData: gardenDataFetcher.gardenData ?? GardenData(), showModal: $showModal1, pin: gardenDataFetcher.gardenData?.pin ?? "0000", background: currentBackground)
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
                   JournalView(background: currentBackground, pin: memorialPin)
               }
               Spacer()
           }.position(CGPoint(x: 200, y: 700.0))

        }
        // Call getGardenData when the view appears
        .onAppear {
            fetchGardenData()
        }.onChange(of: showModal1) { newValue in
            if !newValue {
                fetchGardenData()
            }
        }
    }
    func fetchGardenData() {
        // Call the async function to fetch garden data
        FirebaseHelper.getGardenData(pin: memorialPin) { gardenData in
            // Handle the retrieved garden data
            if let gardenData = gardenData {
                // Update the observed object with the retrieved data
                self.gardenDataFetcher.gardenData = gardenData
            } else {
                // Handle error or no data
                print("Failed to fetch garden data")
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

struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView(pageNumber: 1, memorialPin: "2000", currentBackground: Background.daytime)
    }
}
