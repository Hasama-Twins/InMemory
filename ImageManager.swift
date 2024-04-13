//
//  ImageManager.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/13/24.
//

import SwiftUI

final class ImageManager: NSObject, ObservableObject {
    
    @Published var photos = [String]()
    let appGroupName = "yourAppGroupName" // Replace with your app group name
    let userDefaultsPhotosKey = "userDefaultsPhotosKey"
    
    // MARK: - SETUP
    override init() {
        super.init()
        
        photos = StorageHelper.getImageIdsFromUserDefault()
        print("ids", photos)
    }
    
    func saveImages(images: [UIImage]) {
        
        // Save images in userdefaults
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            
            photos = []
            
            for image in images {
                if let jpegRepresentation = image.jpegData(compressionQuality: 0.5) {
                    
                    let id = UUID().uuidString
                    userDefaults.set(jpegRepresentation, forKey: id)
                    
                    // Append the list and save
                    photos.append(id)
                    saveIntoUserDefaults()
                }
            }
        }
    }
    
    private func saveIntoUserDefaults() {
        if let userDefaults = UserDefaults(suiteName: appGroupName) {
            
            let data = try! JSONEncoder().encode(photos)
            userDefaults.set(data, forKey: userDefaultsPhotosKey)
        }
    }
    
    func getImages() -> [UIImage] {
        var loadedImages = [UIImage]()

        let imageDataIDs: [String]
        if let userDefaults = UserDefaults(suiteName: appGroupName),
           let data = userDefaults.data(forKey: userDefaultsPhotosKey),
           let storedImageIDs = try? JSONDecoder().decode([String].self, from: data) {
            imageDataIDs = storedImageIDs
        } else {
            return []
        }
        
        // Load image data using IDs
        for id in imageDataIDs {
            if let imageData = UserDefaults(suiteName: appGroupName)?.data(forKey: id),
               let image = UIImage(data: imageData) {
                loadedImages.append(image)
            }
        }
        
        return loadedImages
    }
}


