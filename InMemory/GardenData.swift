//
//  GardenData.swift
//  InMemory
//
//  Created by Evelyn Hasama on 4/13/24.
//

import Foundation
import UIKit

class GardenData: ObservableObject, Encodable {
    var pin: String
    var name: String
    var photoIds: [String]
    var bday: String
    var dday: String

    init() {
        // Generate a random 4-digit PIN
        self.pin = String(format: "%04d", Int.random(in: 0...9999))
        self.name = "First Last"
        self.photoIds = []
        let calendar = Calendar.current
        self.bday = GardenData.formattedDate(date: calendar.date(byAdding: .year, value: -10, to: Date())!)
        self.dday = GardenData.formattedDate(date: Date())
    }

    init(pin: String, name: String, photoIds: [String], bday: String, dday: String) {
        self.pin = pin
        self.name = name
        self.photoIds = photoIds
        self.bday = bday
        self.dday = dday
    }

    enum CodingKeys: String, CodingKey {
        case pin, name, photoIds, bday, dday
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pin, forKey: .pin)
        try container.encode(name, forKey: .name)
        try container.encode(photoIds, forKey: .photoIds)
        try container.encode(bday, forKey: .bday)
        try container.encode(dday, forKey: .dday)
    }

    static func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
