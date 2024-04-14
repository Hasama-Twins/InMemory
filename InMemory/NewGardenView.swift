//
//  NewGardenView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//
import SwiftUI
import Firebase

struct NewGardenView: View {
    @Binding var numberOfPages: Int
    @Binding var currentPage: Int
    @Binding var pins: [String]
    @State private var isJoiningMemorial = false
    @State private var pin: String = ""

    var body: some View {
        VStack {
            Button(action: {
                FirebaseHelper.newGardenPin { newPin in
                    if let pin = newPin {
                        print("New pin generated:", pin)
                        createPageWithPin()
                    } else {
                        print("Failed to generate pin.")
                    }
                }
            }) {
                Text("Add Page")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            Spacer().frame(height: 50)
            Button(action: {
                isJoiningMemorial.toggle()
            }) {
                Text("Join Memorial")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            if isJoiningMemorial {
                HStack {
                    TextField("Enter PIN", text: $pin)
                        .padding(10) // Add padding to the text field
                        .font(.system(size: 20)) // Set font size to 20
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150) // Set width of the text field
                        .keyboardType(.numberPad)
                    Button(action: {
                                        // Submit PIN action
                        FirebaseHelper.verifyMemorial(pin: pin) { success in
                            if success {
                                print("Memorial verified.")
                                createPageWithPin()
                            } else {
                                print("Memorial not found.")
                            }
                        }
                                    }) {
                                        Image(systemName: "arrow.right.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.blue)
                                            .padding()
                                    }
                }
            }
        }
    }

    func createPageWithPin() {
        numberOfPages += 1
        currentPage = numberOfPages - 2
        pins.append(pin)
    }
}
