//
//  JournalView.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

struct JournalView: View {
    var background: Background

    var body: some View {
        ZStack {
            background.makeGradient()

            Text("Journal View")
                .foregroundColor(.white)
                .font(.title)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    JournalView(background: .daytime)
}
