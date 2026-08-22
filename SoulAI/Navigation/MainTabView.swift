import SwiftUI

public struct MainTabView: View {
    @Environment(AppState.self) private var appState

    public init() {}

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Tab View Screen Content
            Group {
                switch appState.selectedTab {
                case .discover:
                    DiscoverView()
                case .matches:
                    MatchListView()
                case .conversations:
                    ConversationsListView()
                case .coach:
                    DatingCoachView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Floating Pill Navigation Bar (70px height, 40px radius)
            FloatingTabBar(selectedTab: Bindable(appState).selectedTab)
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
        }
        .sheet(item: Bindable(appState).selectedMatchForChat) { match in
            AIChatView(match: match)
        }
        .sheet(item: Bindable(appState).selectedMatchForDetail) { match in
            MatchDetailView(match: match)
        }
    }
}

#Preview {
    MainTabView()
        .environment(AppState())
}
