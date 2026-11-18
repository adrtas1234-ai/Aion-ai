import SwiftUI

@main
struct AIONApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView()
                .preferredColorScheme(.dark)
        }
    }
}
