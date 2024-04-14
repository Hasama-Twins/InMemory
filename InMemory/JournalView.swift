//
//  JournalView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    var text: String
    var date: Date
    var pin: String
    var user: String
}

struct JournalView: View {
    @EnvironmentObject var userSettings: UserSettings
    var background: Background
    var pin: String
    @State private var notes: [Note] = [Note]()
    // Binding for the text in the blank note
    @State private var blankNoteText: String = ""

    private func fetchNotes() {
        JournalFirebaseHelper.shared.getNotes(for: pin) { notes in
            self.notes = notes
        }
    }

    private func saveNote(note: Note) {
        if note.text.isEmpty { return }

        JournalFirebaseHelper.shared.addNote(note, for: pin) {
            fetchNotes()
        }
    }

    var body: some View {
        ZStack {
            background.makeGradient().ignoresSafeArea()

            VStack {
                Spacer(minLength: 40)

                ScrollView {
                    VStack(spacing: 20) {
                        TextEditor(text: $blankNoteText)
                            .frame(minHeight: 100) // Set minimum height to allow for multiple lines
                            .cornerRadius(10)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 350)
                            .overlay(
                                Text("Start journaling here")
                                    .font(.custom("Gill Sans", size: 18))
                                    .foregroundColor(.gray)
                                    .padding(8) // Adjust padding as needed
                                    .allowsHitTesting(false) // This makes sure the text doesn't capture taps
                                    .offset(x: 5, y: 0) // Adjust the position of the placeholder text
                                    .opacity(blankNoteText.isEmpty ? 1 : 0) // Show placeholder text only when the text is empty
                            )

                        // Display saved notes
                        ForEach(notes) { note in
                            VStack {
                                Text(note.text)
                                    .padding(.vertical, 50)
                                    .font(.custom("Gill Sans", size: 18))
                                    .background(
                                        Rectangle()
                                            .fill(Color.white)
                                            .cornerRadius(10)
                                            .padding()
                                            .frame(width: 350)
                                    )

                                HStack {
                                    Text({
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "MMM d, h:mm a"
                                        let formattedDateAndHour = dateFormatter.string(from: note.date)
                                        return formattedDateAndHour
                                    }())
                                    .font(.custom("Gill Sans", size: 14))
                                    .foregroundColor(.gray)

                                    Text("by \(note.user)")
                                        .font(.custom("Gill Sans", size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        }
                        .padding()
                    }

                    // Button to save note
                    Button("Save Note") {
                        if blankNoteText != "" {

                            saveNote(note: Note(text: blankNoteText, date: Date(), pin: pin, user: userSettings.username))

                            // Clear the text in the blank note
                            blankNoteText = ""
                        }}.padding(.vertical, 30).foregroundColor(background == .nighttime ? .white : .blue).font(.custom("Gill Sans", size: 18))
                }
                .ignoresSafeArea()
            }.onAppear {
                fetchNotes()
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a UserSettings object
        let userSettings = UserSettings()
        userSettings.username = "Summer" // Set the desired username

        // Provide the UserSettings object to the preview
        return JournalView(background: .nighttime, pin: "0000")
            .environmentObject(userSettings)
    }
}
