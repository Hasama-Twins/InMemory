//
//  GardenData.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/13/24.
//

import Foundation
import UIKit

class GardenData: ObservableObject {
    @Published var key: String
    @Published var name: String
    @Published var photos: [UIImage]
    
    init(name: String, photos: [UIImage] = []) {
        self.name = name
        self.photos = photos
        self.key = UUID().uuidString
    }
}
