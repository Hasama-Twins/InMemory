//
//  EditorView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI
import UIKit
import PhotosUI

struct EditorView: View {
    @ObservedObject var gardenData: GardenData
    @Binding var showModal: Bool
    var pin: String
    var background: Background

    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()

    // Properties to hold temporary values for the form
    @State private var newName: String = ""
    @State private var newBirthdate: Date = Date()
    @State private var newDateOfDeath: Date = Date()

    var body: some View {
        ZStack {

            NavigationView {
                Form {
                    Section(header: Text("Memorial Details")) {
                        TextField("Name", text: $newName)
                        DatePicker("Birthday", selection: $newBirthdate, displayedComponents: .date)
                        DatePicker("Date of Passing", selection: $newDateOfDeath, displayedComponents: .date)
                    }
                    Section(header: Text("Share with Others")) {
                        Text("PIN: \(pin)")
                    }
                    Section(header: Text("Photos")) {
                        // Render photos from gardenData.photoIds
                        if !selectedImages.isEmpty {
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
                            Text("No photos available")
                                .foregroundColor(.secondary)
                        }
                        PhotosPicker(selection: $selectedItems, matching: .any(of: [.images, .not(.videos)])) {
                            Label("Edit Photos", systemImage: "pencil")
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
                            }
                        }
                    }
                }
                .background(background.makeGradient())
                .scrollContentBackground(.hidden)
                .navigationTitle("Edit Memorial")
                .navigationBarItems(
                    leading: Button("Cancel") {
                        showModal = false
                    },
                    trailing: Button("Save") {
                        // Save person details
                        gardenData.name = newName
                        gardenData.bday = newBirthdate
                        gardenData.dday = newDateOfDeath
                        FirebaseHelper.updateMemorial(documentId: gardenData.documentId ?? "", updatedData: gardenData) { error in
                            if let error = error {
                                print("Error updating memorial: \(error.localizedDescription)")
                            } else {
                                showModal = false
                            }
                        }
                    }
                )
                .onAppear {
                    // Initialize temporary properties with original values
                    newName = gardenData.name
                    newBirthdate = gardenData.bday
                    newDateOfDeath = gardenData.dday
                    selectedImages = [] // TODO: fetch from cloud?
                }
            }
        }
    }
}

#Preview {
    EditorView(gardenData: GardenData(), showModal: .constant(true), pin: "2000", background: .daytime)
}
