import SwiftUI

public struct GlassCard<Content: View>: View {
    let cornerRadius: CGFloat
    let padding: CGFloat
    let content: Content

    public init(
        cornerRadius: CGFloat = DesignTokens.cornerRadiusCard,
        padding: CGFloat = DesignTokens.spacingM,
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(AppColors.borderSubtle, lineWidth: 1)
            )
            .shadow(color: AppColors.subtleShadow, radius: 8, x: 0, y: 3)
    }
}
