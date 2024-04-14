//
//  GardenData.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/13/24.
//

import Foundation
import UIKit

class GardenData: ObservableObject {
    var pin: String
    var name: String
    var photoIds: [String]
    var bday: Date
    var dday: Date
    var documentId: String?

    init() {
        // Generate a random 4-digit PIN
        self.pin = String(format: "%04d", Int.random(in: 0...9999))
        self.name = "First Last"
        self.photoIds = []
        let calendar = Calendar.current
        let currentYear = Calendar.current.component(.year, from: Date())
        self.bday = calendar.date(from: DateComponents(year: 2000, month: 1, day: 1))!
        self.dday = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
    }

    init(pin: String, name: String, photoIds: [String], bday: Date, dday: Date, documentId: String) {
        self.pin = pin
        self.name = name
        self.photoIds = photoIds
        self.bday = bday
        self.dday = dday
        self.documentId = documentId
    }

    static func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
