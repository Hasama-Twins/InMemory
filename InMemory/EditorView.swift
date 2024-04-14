//
//  EditorView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct EditorView: View {
    @ObservedObject var gardenData: GardenData
    @Binding var showModal: Bool
    
    // Properties to hold temporary values for the form
    @State private var newName: String = ""
    @State private var newBirthdate: Date = Date()
    @State private var newDateOfDeath: Date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Person Details")) {
                    TextField("Name", text: $newName)
                    DatePicker("Birthdate", selection: $newBirthdate,displayedComponents: .date)
                    DatePicker("Date of Death", selection: $newDateOfDeath, displayedComponents: .date)
                }
            }
            .navigationTitle("Add Person")
            .navigationBarItems(
                leading: Button("Cancel") {
                    showModal = false
                },
                trailing: Button("Save") {
                    // Save person details
                    gardenData.name = newName
                    gardenData.bday = newBirthdate
                    gardenData.dday = newDateOfDeath
                    showModal = false
                }
            )
            .onAppear {
                // Initialize temporary properties with original values
                newName = gardenData.name
                newBirthdate = gardenData.bday
                newDateOfDeath = gardenData.dday
            }
        }
    }
}

#Preview {
    EditorView(gardenData: GardenData(), showModal: .constant(true))
}
