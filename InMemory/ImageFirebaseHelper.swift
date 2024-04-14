//
//  ImageFirebaseHelper.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/14/24.
//

import Foundation
import FirebaseStorage
import UIKit

struct ImageFirebaseHelper {

    static func getPhotoFromPath(path: String, completion: @escaping (UIImage?) -> Void) {
        print("path \(path)")
        let storageRef = Storage.storage().reference()
        let childRef = storageRef.child(path)

        // Download the image data from Firebase Storage
        childRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil || data == nil {
                print("Error downloading image or no data")
                completion(nil)
            } else if let imageData = data, let image = UIImage(data: imageData) {
                // If the image data is successfully downloaded, create UIImage
                completion(image)
            } else {
                // Handle the case where the downloaded data is not valid or not an image
                print("Invalid image data")
                completion(nil)
            }
        }
    }

    static func uploadPhoto(image: UIImage, gardenData: GardenData) {
        let storageRef = Storage.storage().reference()
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            print("Failed to convert image to JPEG data")
            return
        }
        print("putData \(imageData)")
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        let uploadTask = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }

            // Handle successful upload
            if let metadata = metadata {
                print("Image uploaded successfully!")
                // save to associated Firestore document
                gardenData.photoIds.append(path)

            // Retrieve download URL
            fileRef.downloadURL { url, error in
                if let error = error {
                    print("Error retrieving download URL: \(error.localizedDescription)")
                    return
                }
                if let downloadURL = url {
                    // Use downloadURL to save reference in Firestore or perform other actions
                    print("Download URL: \(downloadURL)")
                }
            }
        }

        }

    }
}
