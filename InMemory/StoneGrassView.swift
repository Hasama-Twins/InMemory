//
//  StoneGrassView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct StoneGrassView: View {
    var body: some View {
        ZStack {
            Image("headstone")
                .resizable()
                .frame(width: 380, height: 500)
                .offset(x: 0, y: -50)
            Image("grass")
                .resizable()
                .frame(width: 400, height: 400)
                .offset(x: 0, y: 340)
        }
    }
}

#Preview {
    StoneGrassView()
}
