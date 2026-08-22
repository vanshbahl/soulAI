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
                case .coach:
                    DatingCoachView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom Floating Frosted Glass Tab Bar
            customFloatingTabBar
                .padding(.horizontal, 24)
                .padding(.bottom, 18)
        }
        .sheet(item: Bindable(appState).selectedMatchForChat) { match in
            AIChatView(match: match)
        }
    }

    // MARK: - Custom Floating Tab Bar
    private var customFloatingTabBar: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                let isSelected = appState.selectedTab == tab
                Button(action: {
                    #if os(iOS)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    #endif
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        appState.selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: isSelected ? 20 : 18, weight: isSelected ? .bold : .medium))
                            .foregroundStyle(
                                isSelected
                                ? AnyShapeStyle(AppColors.soulGradient)
                                : AnyShapeStyle(Color.white.opacity(0.45))
                            )
                            .scaleEffect(isSelected ? 1.15 : 1.0)

                        Text(tab.rawValue)
                            .font(.system(size: 10, weight: isSelected ? .bold : .medium, design: .rounded))
                            .foregroundColor(isSelected ? .white : Color.white.opacity(0.45))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(Color.white.opacity(0.06))
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [Color.white.opacity(0.3), Color.white.opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 10)
    }
}

#Preview {
    MainTabView()
        .environment(AppState())
}
