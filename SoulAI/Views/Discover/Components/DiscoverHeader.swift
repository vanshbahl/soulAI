import SwiftUI

public enum DiscoverMode: String, CaseIterable {
    case forYou = "For You"
    case nearby = "Nearby"
}

public struct DiscoverHeader: View {
    @Binding var selectedMode: DiscoverMode
    let onFilterTap: () -> Void

    public init(selectedMode: Binding<DiscoverMode>, onFilterTap: @escaping () -> Void) {
        self._selectedMode = selectedMode
        self.onFilterTap = onFilterTap
    }

    public var body: some View {
        HStack(alignment: .center) {
            // Left: SoulAI Minimal Logo
            HStack(spacing: 3) {
                Text("SoulAI")
                    .font(.system(size: 26, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)

                Circle()
                    .fill(AppColors.accentCoral)
                    .frame(width: 5, height: 5)
                    .offset(y: -4)
            }

            Spacer()

            // Center: Mode Selector Pills ("For You" / "Nearby")
            HStack(spacing: 4) {
                ForEach(DiscoverMode.allCases, id: \.self) { mode in
                    let isSelected = selectedMode == mode
                    Button(action: {
                        #if os(iOS)
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        #endif
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            selectedMode = mode
                        }
                    }) {
                        Text(mode.rawValue)
                            .font(.system(size: 13, weight: isSelected ? .semibold : .medium))
                            .foregroundColor(isSelected ? AppColors.textPrimary : AppColors.textSecondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                isSelected ? AppColors.surfaceWhite : Color.clear
                            )
                            .clipShape(Capsule())
                            .shadow(color: isSelected ? AppColors.subtleShadow : Color.clear, radius: 4, y: 1)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(3)
            .background(AppColors.surfaceNeutral.opacity(0.8))
            .clipShape(Capsule())

            Spacer()

            // Right: Filter Floating Circular Button
            Button(action: {
                #if os(iOS)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                #endif
                onFilterTap()
            }) {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                    .frame(width: 38, height: 38)
                    .background(AppColors.surfaceWhite)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(AppColors.borderSubtle, lineWidth: 1)
                    )
                    .shadow(color: AppColors.subtleShadow, radius: 6, y: 2)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    DiscoverHeader(selectedMode: .constant(.forYou), onFilterTap: {})
        .padding()
        .background(AppColors.backgroundWarm)
}
