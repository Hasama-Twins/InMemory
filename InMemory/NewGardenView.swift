//
//  NewGardenView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct NewGardenView: View {
    @Binding var numberOfPages: Int
    @Binding var currentPage: Int

    var body: some View {
        Button(action: {
            numberOfPages += 1
            currentPage = numberOfPages - 2
        }) {
            Text("Add Page")
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(8)
        }
    }
}
