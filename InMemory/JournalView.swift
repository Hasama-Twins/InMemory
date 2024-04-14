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
}

struct JournalView: View {
    var background: Background
    @State private var notes: [Note] = [Note]()
    // Binding for the text in the blank note
    @State private var blankNoteText: String = ""

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
                                    .foregroundColor(.gray)
                                    .padding(8) // Adjust padding as needed
                                    .allowsHitTesting(false) // This makes sure the text doesn't capture taps
                                    .offset(x: 5, y: 0) // Adjust the position of the placeholder text
                                    .opacity(blankNoteText.isEmpty ? 1 : 0) // Show placeholder text only when the text is empty
                            )

                        // Display saved notes
                        ForEach(notes) { note in
                            Text(note.text)
                                .padding(.vertical, 50)
                                .background(
                                    Rectangle()
                                        .fill(Color.white) // Set the background color to white
                                        .cornerRadius(10) // Set corner radius for rounded corners (optional)
                                        .padding()
                                        .frame(width: 350)
                                )
                        }
                    }
                    .padding()
                }

                // Button to save note
                Button("Save Note") {
                    if blankNoteText != "" {
                        // Add the blank note to the notes array
                        notes.insert(Note(text: blankNoteText), at: 0)
                        // Clear the text in the blank note
                        blankNoteText = ""
                    }}.padding()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    JournalView(background: .daytime)
}
