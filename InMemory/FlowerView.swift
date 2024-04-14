//
//  FrameView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct FlowerView: View {
    @State private var currentFlowerIndex = 0
    let flowerNames = ["flower1", "flower2", "flower3", "flower4", "flower5", "flower6"]

    var body: some View {
        Image(flowerNames[currentFlowerIndex])
            .resizable()
            .frame(width: 100, height: 150)
            .onTapGesture {
                currentFlowerIndex = (currentFlowerIndex + 1) % flowerNames.count
            }
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView()
    }
}
