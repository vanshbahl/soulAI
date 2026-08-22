import SwiftUI

public enum DesignTokens {
    public static let cornerRadiusSmall: CGFloat = 12
    public static let cornerRadiusMedium: CGFloat = 20
    public static let cornerRadiusLarge: CGFloat = 28
    public static let cornerRadiusPill: CGFloat = 999

    public static let spacingXS: CGFloat = 6
    public static let spacingS: CGFloat = 12
    public static let spacingM: CGFloat = 18
    public static let spacingL: CGFloat = 24
    public static let spacingXL: CGFloat = 32

    public static let cardShadow = Color.black.opacity(0.35)
}

public struct GlassmorphicModifier: ViewModifier {
    var cornerRadius: CGFloat
    var strokeColor: Color

    public init(cornerRadius: CGFloat = DesignTokens.cornerRadiusMedium, strokeColor: Color = AppColors.glassBorder) {
        self.cornerRadius = cornerRadius
        self.strokeColor = strokeColor
    }

    public func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [strokeColor.opacity(0.6), strokeColor.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: DesignTokens.cardShadow, radius: 16, x: 0, y: 8)
    }
}

public extension View {
    func glassCardStyle(cornerRadius: CGFloat = DesignTokens.cornerRadiusMedium, strokeColor: Color = AppColors.glassBorder) -> some View {
        self.modifier(GlassmorphicModifier(cornerRadius: cornerRadius, strokeColor: strokeColor))
    }
}
