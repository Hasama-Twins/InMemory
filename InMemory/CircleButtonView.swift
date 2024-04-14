//
//  CircleButtonView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct ActionButton: View {
    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            CircleButton(icon: icon)
        }
    }
}

struct CircleButton: View {
    var icon: String

    var body: some View {
        Circle()
            .fill(Color.green.opacity(0.8))
            .frame(width: 60, height: 60)
            .overlay(
                Image(systemName: icon)
                    .foregroundColor(.white)
            )
    }
}
