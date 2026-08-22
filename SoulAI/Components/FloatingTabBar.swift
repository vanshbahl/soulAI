import SwiftUI

public struct FloatingTabBar: View {
    @Binding var selectedTab: AppTab

    public init(selectedTab: Binding<AppTab>) {
        self._selectedTab = selectedTab
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(AppTab.allCases) { tab in
                let isSelected = selectedTab == tab
                Button(action: {
                    #if os(iOS)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    #endif
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                        selectedTab = tab
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
                    .frame(height: 50)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 70)
        .background(AppColors.surfaceWhite)
        .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .stroke(AppColors.borderSubtle, lineWidth: 1)
        )
        .shadow(color: AppColors.pillShadow, radius: 18, x: 0, y: 6)
    }
}

#Preview {
    FloatingTabBar(selectedTab: .constant(.discover))
        .padding()
        .background(AppColors.backgroundWarm)
}
