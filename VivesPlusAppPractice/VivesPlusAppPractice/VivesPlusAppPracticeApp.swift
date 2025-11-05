//
//  VivesPlusAppPracticeApp.swift
//  VivesPlusAppPractice
//
//  Created by Batiste Vancoillie on 05/11/2025.
//

import SwiftUI

@main
struct VivesPlusAppPracticeApp: App {
    @State private var dataStore = UurroosterDataStore()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(dataStore)
        }
    }
}
