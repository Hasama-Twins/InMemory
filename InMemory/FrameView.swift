//
//  FrameView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct FrameView: View {
    @State private var currentFrame = "frame1"

    var body: some View {
        Image(currentFrame)
            .resizable()
            .frame(width: 250, height: 250)
            .onTapGesture {
                switch currentFrame {
                case "frame1":
                    currentFrame = "frame2"
                case "frame2":
                    currentFrame = "frame3"
                case "frame3":
                    currentFrame = "frame4"
                case "frame4":
                    currentFrame = "frame1"
                default:
                    break
                }
            }
    }
}

#Preview {
    FrameView()
}
