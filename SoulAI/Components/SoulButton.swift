import SwiftUI

public enum SoulButtonStyle {
    case primaryGradient
    case secondaryGlass
    case outline
    case glow
}

public struct SoulButton: View {
    let title: String
    let iconName: String?
    let style: SoulButtonStyle
    let fullWidth: Bool
    let action: () -> Void

    @State private var isPressed: Bool = false

    public init(
        title: String,
        iconName: String? = nil,
        style: SoulButtonStyle = .primaryGradient,
        fullWidth: Bool = true,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.iconName = iconName
        self.style = style
        self.fullWidth = fullWidth
        self.action = action
    }

    public var body: some View {
        Button(action: {
            #if os(iOS)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            #endif
            action()
        }) {
            HStack(spacing: 8) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 15, weight: .semibold))
                }
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .foregroundColor(foregroundColor)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(borderOverlay)
            .shadow(color: shadowColor, radius: 10, x: 0, y: 4)
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }

    private var foregroundColor: Color {
        switch style {
        case .primaryGradient, .glow:
            return .white
        case .secondaryGlass:
            return AppColors.textPrimary
        case .outline:
            return AppColors.accentCoral
        }
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primaryGradient, .glow:
            AppColors.accentCoral
        case .secondaryGlass:
            AppColors.surfaceWhite
        case .outline:
            Color.clear
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        switch style {
        case .outline:
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(AppColors.accentCoral, lineWidth: 1.5)
        case .secondaryGlass:
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(AppColors.borderSubtle, lineWidth: 1)
        default:
            EmptyView()
        }
    }

    private var shadowColor: Color {
        switch style {
        case .primaryGradient, .glow:
            return AppColors.buttonShadow
        case .secondaryGlass:
            return AppColors.subtleShadow
        default:
            return Color.clear
        }
    }
}
