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
   @EnvironmentObject var userSettings: UserSettings
   @State private var pin: String = ""
   @State private var isEditing: Bool = false
    @State private var isJoiningMemorial = false

    var body: some View {
        ZStack {
            GrassView()

            VStack {
                if isEditing {
                    HStack {
                        TextField("Enter Username", text: $userSettings.username)
                            .padding(10)
                            .font(.custom("Gill Sans", size: 18))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 190)
                        Button(action: {
                            self.isEditing = false
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                                .padding()
                        }.shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                } else {
                    Text("Hi, \(userSettings.username)")
                        .font(.custom("Gill Sans", size:24))
                        .foregroundColor(.white)
                }

                Spacer().frame(height: 50)

                Button(action: {
                    FirebaseHelper.newGardenPin { newPin in
                        if let pin = newPin {
                            print("New pin generated:", pin)
                            createPageWithPin(pin: pin)
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
                        .font(.custom("Gill Sans", size: 18))
                }.shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                Spacer().frame(height: 50)
                Button(action: {
                    isJoiningMemorial.toggle()
                }) {
                    Text("Join Memorial")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .font(.custom("Gill Sans", size: 18))
                }.shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                if isJoiningMemorial {
                    HStack {
                        TextField("Enter PIN", text: $pin)
                            .padding(10) // Add padding to the text field
                            .font(.custom("Gill Sans", size: 20))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150) // Set width of the text field
                            .keyboardType(.numberPad)
                        Button(action: {
                            // Submit PIN action
                            FirebaseHelper.verifyMemorial(pin: pin) { success in
                                if success {
                                    print("Memorial verified.")
                                    createPageWithPin(pin: pin)
                                } else {
                                    print("Memorial not found.")
                                }
                            }
                        }) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title)
                                .foregroundColor(.blue)
                                .padding()
                        }.shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                }
            }.onAppear {
                self.isEditing = userSettings.username == ""
            }
        }
    }

    func createPageWithPin(pin: String) {
        numberOfPages += 1
        currentPage = numberOfPages - 2
        pins.append(pin)
    }
}

struct NewGardenView_Previews: PreviewProvider {
    static var previews: some View {
            // Create a mock UserSettings object
            let userSettings = UserSettings()
            userSettings.username = "" // Set some initial value for testing

            // Provide the mock UserSettings object to the preview
            return NewGardenView(
                numberOfPages: .constant(3),
                currentPage: .constant(2),
                pins: .constant([])
            )
            .environmentObject(userSettings) // Inject the mock UserSettings object
        }
}
