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
            HStack(spacing: 10) {
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 16, weight: .bold))
                }
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(backgroundView)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusMedium, style: .continuous))
            .overlay(borderOverlay)
            .shadow(color: shadowColor, radius: 14, x: 0, y: 6)
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }

    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primaryGradient:
            AppColors.soulGradient
        case .secondaryGlass:
            Color.white.opacity(0.12)
                .background(.ultraThinMaterial)
        case .outline:
            Color.clear
        case .glow:
            AppColors.auroraGradient
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        switch style {
        case .outline:
            RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusMedium, style: .continuous)
                .stroke(AppColors.primaryRose, lineWidth: 1.5)
        case .secondaryGlass:
            RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusMedium, style: .continuous)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        default:
            EmptyView()
        }
    }

    private var shadowColor: Color {
        switch style {
        case .primaryGradient:
            return AppColors.primaryRose.opacity(0.35)
        case .glow:
            return AppColors.auroraTeal.opacity(0.35)
        default:
            return Color.black.opacity(0.15)
        }
    }
}
