//
//  Backgrounds.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

enum Background {
    case daytime
    case nighttime
    case sunset

    func makeGradient() -> LinearGradient {
        switch self {
        case .daytime:
            return LinearGradient(
                gradient: Gradient(colors: [Color(red: 102/255, green: 178/255, blue: 255/255), Color(red: 204/255, green: 229/255, blue: 255/255)]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .nighttime:
            return LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.blue]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .sunset:
            return LinearGradient(
                gradient: Gradient(colors: [Color(red: 255/255, green: 102/255, blue: 102/255), Color(red: 255/255, green: 204/255, blue: 102/255)]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
