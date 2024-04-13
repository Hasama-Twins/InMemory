//
//  InMemoryApp.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI

@main
struct InMemoryApp: App {
    var body: some Scene {
        WindowGroup {
            TempContentView()
                .environmentObject(ImageManager())
        }
    }
}
