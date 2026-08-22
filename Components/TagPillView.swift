import SwiftUI

public struct TagPillView: View {
    let title: String
    let icon: String?
    let isSelected: Bool
    let isSelectable: Bool
    let action: (() -> Void)?

    public init(
        title: String,
        icon: String? = nil,
        isSelected: Bool = false,
        isSelectable: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.isSelectable = isSelectable
        self.action = action
    }

    public var body: some View {
        Group {
            if isSelectable {
                Button(action: {
                    #if os(iOS)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    #endif
                    action?()
                }) {
                    pillContent
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                pillContent
            }
        }
    }

    private var pillContent: some View {
        HStack(spacing: 6) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(isSelected ? .white : AppColors.softLilac)
            }

            Text(title)
                .font(.system(size: 13, weight: isSelected ? .bold : .medium, design: .rounded))
                .foregroundColor(isSelected ? .white : Color.white.opacity(0.85))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(
                    isSelected
                    ? AnyShapeStyle(AppColors.soulGradient)
                    : AnyShapeStyle(Color.white.opacity(0.08))
                )
        )
        .overlay(
            Capsule()
                .stroke(
                    isSelected
                    ? Color.white.opacity(0.4)
                    : Color.white.opacity(0.12),
                    lineWidth: 1
                )
        )
        .shadow(
            color: isSelected ? AppColors.primaryRose.opacity(0.3) : Color.clear,
            radius: 8,
            x: 0,
            y: 3
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
