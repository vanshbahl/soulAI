import SwiftUI

@main
struct SoulAIApp: App {
    @State private var appState = AppState(isOnboarded: false)

    var body: some Scene {
        WindowGroup {
            Group {
                if appState.isOnboarded {
                    MainTabView()
                } else {
                    OnboardingView()
                }
            }
            .environment(appState)
            .preferredColorScheme(.dark)
        }
    }
}
