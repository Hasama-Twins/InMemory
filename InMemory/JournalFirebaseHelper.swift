//
//  JournalFirebaseHelper.swift
//  InMemory
//
//  Created by Summer Hasama on 4/14/24.
//

import Foundation
import FirebaseFirestore

class JournalFirebaseHelper {
    static let shared = JournalFirebaseHelper()
    private let db = Firestore.firestore(database: "in-memory")

    func getNotes(for filterPin: String, completion: @escaping ([Note]) -> Void) {
        db.collection("journal")
            .whereField("pin", isEqualTo: filterPin)
            .order(by: "date", descending: true)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    completion([])
                } else {
                    var notes = [Note]()
                    print("number of journal entries found: \(querySnapshot!.documents.count)")
                    for document in querySnapshot!.documents {
                        let noteData = document.data()

                        // Safely unwrap optional values using optional binding
                        let text = noteData["text"] as? String ?? "Default text"
                        let date = (noteData["date"] as? Timestamp)?.dateValue() ?? Date()
                        let pin = noteData["pin"] as? String ?? "Default pin"
                        let user = noteData["user"] as? String ?? "Default user"

                        notes.append(Note(text: text, date: date, pin: pin, user: user))
                    }
                    completion(notes)
                }
            }
    }

    func addNote(_ note: Note, for filterPin: String, completion: @escaping () -> Void) {
        db.collection("journal").addDocument(data: [
            "text": note.text,
            "date": note.date,
            "pin": filterPin,
            "user": note.user
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                completion()
            }
        }
    }
}
