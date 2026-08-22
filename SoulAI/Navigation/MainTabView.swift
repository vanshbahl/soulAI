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

            // Floating Pill Navigation Bar
            floatingTabBar
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
        }
        .sheet(item: Bindable(appState).selectedMatchForChat) { match in
            AIChatView(match: match)
        }
        .sheet(item: Bindable(appState).selectedMatchForDetail) { match in
            MatchDetailView(match: match)
        }
    }

    // MARK: - Floating Pill Tab Bar
    private var floatingTabBar: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                let isSelected = appState.selectedTab == tab
                Button(action: {
                    #if os(iOS)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    #endif
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                        appState.selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: isSelected ? tab.selectedIconName : tab.iconName)
                            .font(.system(size: 20, weight: isSelected ? .semibold : .regular))
                            .foregroundColor(isSelected ? AppColors.accentCoral : AppColors.textMuted)
                            .scaleEffect(isSelected ? 1.08 : 1.0)

                        Text(tab.rawValue)
                            .font(.system(size: 10, weight: isSelected ? .semibold : .medium))
                            .foregroundColor(isSelected ? AppColors.accentCoral : AppColors.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(AppColors.surfaceWhite)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(AppColors.borderSubtle, lineWidth: 1)
        )
        .shadow(color: AppColors.pillShadow, radius: 16, x: 0, y: 6)
    }
}

#Preview {
    MainTabView()
        .environment(AppState())
}
