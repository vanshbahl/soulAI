import SwiftUI

public struct GlassCard<Content: View>: View {
    let cornerRadius: CGFloat
    let padding: CGFloat
    let strokeGradient: LinearGradient
    let content: Content

    public init(
        cornerRadius: CGFloat = DesignTokens.cornerRadiusMedium,
        padding: CGFloat = DesignTokens.spacingM,
        strokeGradient: LinearGradient = LinearGradient(
            colors: [Color.white.opacity(0.25), Color.white.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.strokeGradient = strokeGradient
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.07),
                                        Color.white.opacity(0.01)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(strokeGradient, lineWidth: 1)
            )
            .shadow(color: AppColors.backgroundDark.opacity(0.6), radius: 12, x: 0, y: 6)
    }
}
