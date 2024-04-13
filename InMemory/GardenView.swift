//
//  GardenView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct GardenView: View {
    let pageNumber: Int
    
    var body: some View {
        Text("Page \(pageNumber + 1) Content")
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}
