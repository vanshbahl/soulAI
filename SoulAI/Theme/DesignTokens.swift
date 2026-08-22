import SwiftUI

public enum DesignTokens {
    // Corner Radii
    public static let cornerRadiusHeroCard: CGFloat = 28
    public static let cornerRadiusCard: CGFloat = 20
    public static let cornerRadiusSmall: CGFloat = 12
    public static let cornerRadiusPill: CGFloat = 999

    // Spacing
    public static let spacingXS: CGFloat = 4
    public static let spacingS: CGFloat = 8
    public static let spacingM: CGFloat = 16
    public static let spacingL: CGFloat = 24
    public static let spacingXL: CGFloat = 32

    // Shadows
    public static let subtleShadowRadius: CGFloat = 12
    public static let cardShadowColor = AppColors.subtleShadow
}

public struct CleanCardModifier: ViewModifier {
    var cornerRadius: CGFloat
    var backgroundColor: Color

    public init(cornerRadius: CGFloat = DesignTokens.cornerRadiusCard, backgroundColor: Color = AppColors.surfaceWhite) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }

    public func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(AppColors.borderSubtle, lineWidth: 1)
            )
            .shadow(color: DesignTokens.cardShadowColor, radius: 10, x: 0, y: 4)
    }
}

public extension View {
    func cleanCardStyle(cornerRadius: CGFloat = DesignTokens.cornerRadiusCard, backgroundColor: Color = AppColors.surfaceWhite) -> some View {
        self.modifier(CleanCardModifier(cornerRadius: cornerRadius, backgroundColor: backgroundColor))
    }

    // Editorial Typography Modifiers
    func soulHeroHeadline() -> some View {
        self.font(.system(size: 34, weight: .bold, design: .serif))
            .foregroundColor(AppColors.textPrimary)
    }

    func soulSectionTitle() -> some View {
        self.font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundColor(AppColors.textPrimary)
    }

    func soulBodyText() -> some View {
        self.font(.system(size: 15, weight: .regular))
            .foregroundColor(AppColors.textPrimary)
    }

    func soulMetadataText() -> some View {
        self.font(.system(size: 13, weight: .medium))
            .foregroundColor(AppColors.textSecondary)
    }
}
