//
//  TempContentView.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/13/24.
//

import SwiftUI
import UIKit
import PhotosUI

struct TempContentView: View {
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    @EnvironmentObject var imageManager: ImageManager
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if selectedImages.count > 0 {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(selectedImages, id: \.self) { img in
                                Image(uiImage: img)
                                    .resizable()
                                    .frame(width: 200, height: 200)
                            }
                        }
                    }
                } else {
                    Image("preview")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                PhotosPicker(selection: $selectedItems, matching: .any(of: [.images, .not(.videos)])) {
                    Label("Pick Photo", systemImage: "idk")
                }.onChange(of: selectedItems) {
                    newValues in
                    Task {
                        // convert picked items to images
                        selectedImages = []
                        for value in newValues {
                            if let imageData = try? await value.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                                selectedImages.append(image)
                            }
                        }
                        imageManager.saveImages(images: selectedImages)
                    }
                }
            }
        }
        .onAppear {
            // Retrieve images from UserDefaults when the view appears
            selectedImages = imageManager.getImages()
        }
    }
    
}

