import SwiftUI

@main
struct VivesPlusAppApp: App {
    // maak 1 datastore voor de hele app
    @State private var dataStore = UurroosterDataStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataStore)
        }
    }
}
