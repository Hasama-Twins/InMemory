//
//  FirebaseHelper.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/13/24.
//
import Foundation
import FirebaseFirestore
import FirebaseCore

struct FirebaseHelper {
    static let db = Firestore.firestore(database: "in-memory")

    static func verifyMemorial(pin: String, completion: @escaping (Bool) -> Void) {

        // Construct a query to find memorial documents with the specified PIN
        db.collection("memorial").whereField("pin", isEqualTo: pin).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying documents: \(error)")
                completion(false)
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(false)
                return
            }

            if documents.isEmpty {
                print("No memorial found with the specified PIN:", pin)
                completion(false)
            } else {
                print("Success: Memorial found with the specified PIN")
                completion(true)
            }
        }
    }

    static func getFirebaseData(pin: String, completion: @escaping ([DocumentSnapshot]?, Error?) -> Void) {
        // Construct a query to find memorial documents with the specified PIN
        db.collection("memorial").whereField("pin", isEqualTo: pin).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying documents: \(error)")
                completion(nil, error)
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                completion(nil, nil)
                return
            }

            if documents.isEmpty {
                print("No memorial found with the specified PIN:", pin)
            } else {
                print("Success: Memorial found with the specified PIN")
            }
            completion(documents, nil)
        }
    }

    static func newGardenPin(completion: @escaping (String?) -> Void) {
        let gardenData = GardenData()
        let pin: String = gardenData.pin
        do {
            let gardenDataDict: [String: Any] = [
                "name": gardenData.name,
                "photoIds": gardenData.photoIds,
                "bday": gardenData.bday,
                "dday": gardenData.dday,
                "pin": gardenData.pin,
                "candle": gardenData.candle,
                "inscription": gardenData.inscription
            ]
            // Add a new document with a generated ID
            db.collection("memorial").addDocument(data: gardenDataDict) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(nil)
                } else {
                    print("Document added with PIN: \(pin)")
                    completion(pin)
                }
            }
        } catch {
            print("Error encoding gardenData to JSON: \(error)")
            completion(nil)
        }
    }

    static func parseDocumentsToGardenData(documents: [DocumentSnapshot]) -> GardenData? {
        guard let document = documents.first else {
            print("No docs found")
            return nil
        }

        guard let data = document.data() else {
            print("Unable to extract data from document")
            return nil
        }

        // Extract data from Firestore document
        guard let name = data["name"] as? String,
              let pin = data["pin"] as? String,
              let photoIds = data["photoIds"] as? [String],
              let bday = (data["bday"] as? Timestamp)?.dateValue(),
              let dday = (data["dday"] as? Timestamp)?.dateValue(),
              let candle = data["candle"] as? Bool,
              let inscription = data["inscription"] as? String
        else {
            print("returning during extract")
            // Required data is missing or has incorrect format
            return nil
        }

        // Create and return GardenData object
        return GardenData(pin: pin, name: name, photoIds: photoIds, bday: bday, dday: dday, documentId: document.documentID, candle: candle, inscription: inscription)
    }

    static func getGardenData(pin: String, completion: @escaping (GardenData?) -> Void) {
        FirebaseHelper.getFirebaseData(pin: pin) { documents, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil) // Call completion handler with nil to indicate failure
            } else if let documents = documents {
                // Parse documents to create GardenData object
                if let gardenData = parseDocumentsToGardenData(documents: documents) {
                    completion(gardenData) // Call completion handler with retrieved GardenData
                } else {
                    print("failed to parse json to GardenData")
                    completion(nil) // Call completion handler with nil to indicate failure
                }
            }
        }
    }

    // Update an existing memorial with the provided documentId
    static func updateMemorial(documentId: String, updatedData: GardenData, completion: @escaping (Error?) -> Void) {

        // Convert GardenData to a dictionary
        let gardenDataDict: [String: Any] = [
            "name": updatedData.name,
            "photoIds": updatedData.photoIds,
            "bday": updatedData.bday,
            "dday": updatedData.dday,
            "inscription": updatedData.inscription
            // Add any other fields you want to update
        ]

        // Update the memorial document with the provided data
        db.collection("memorial").document(documentId).setData(gardenDataDict, merge: true) { error in
            if let error = error {
                print("Error updating memorial: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Memorial updated successfully with id \(documentId) and data \(gardenDataDict)")
                completion(nil)
            }
        }

    }

    // Update an existing memorial with the provided documentId
    static func updateCandle(documentId: String, candleOn: Bool, completion: @escaping (Error?) -> Void) {

        // Convert GardenData to a dictionary
        let gardenDataDict: [String: Any] = [
            "candle": candleOn
        ]

        // Update the memorial document with the provided data
        db.collection("memorial").document(documentId).setData(gardenDataDict, merge: true) { error in
            if let error = error {
                print("Error updating memorial: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Candle updated successfully with id \(documentId) and candle \(gardenDataDict)")
                completion(nil)
            }
        }
    }

}
