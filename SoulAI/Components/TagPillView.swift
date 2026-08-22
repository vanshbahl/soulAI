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
        HStack(spacing: 5) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 11))
                    .foregroundColor(isSelected ? .white : AppColors.accentCoral)
            }

            Text(title)
                .font(.system(size: 13, weight: isSelected ? .semibold : .medium))
                .foregroundColor(isSelected ? .white : AppColors.textPrimary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
        .background(
            isSelected ? AppColors.accentCoral : AppColors.surfaceWhite.opacity(0.85)
        )
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(isSelected ? Color.clear : AppColors.borderSubtle, lineWidth: 1)
        )
        .shadow(color: isSelected ? AppColors.buttonShadow : Color.clear, radius: 4, x: 0, y: 2)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isSelected)
    }
}
