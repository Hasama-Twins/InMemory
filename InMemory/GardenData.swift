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
    @Published var photoIds: [String]
    @Published var bday: Date
    @Published var dday: Date
    
    
    init() {
        self.key = UUID().uuidString
        self.name = "First Last"
        self.photoIds = []
        let calendar = Calendar.current
        self.bday = calendar.date(byAdding: .year, value: -10, to: Date())!
        self.dday = Date()
    }
}
