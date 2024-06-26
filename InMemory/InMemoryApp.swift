//
//  InMemoryApp.swift
//  InMemory
//
//  Created by Summer Hasama on 4/13/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct InMemoryApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let userSettings = UserSettings()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userSettings)
        }
    }
}
