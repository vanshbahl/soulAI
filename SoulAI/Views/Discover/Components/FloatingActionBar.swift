import SwiftUI

public struct FloatingActionBar: View {
    let onPass: () -> Void
    let onAiInsight: () -> Void
    let onLike: () -> Void

    public init(onPass: @escaping () -> Void, onAiInsight: @escaping () -> Void, onLike: @escaping () -> Void) {
        self.onPass = onPass
        self.onAiInsight = onAiInsight
        self.onLike = onLike
    }

    public var body: some View {
        HStack(spacing: 28) {
            // Left: Pass (✕ in white circular button with subtle shadow)
            Button(action: {
                #if os(iOS)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                #endif
                onPass()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textSecondary)
                    .frame(width: 60, height: 60)
                    .background(AppColors.surfaceWhite)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(AppColors.borderSubtle, lineWidth: 1)
                    )
                    .shadow(color: AppColors.subtleShadow, radius: 10, y: 4)
            }
            .buttonStyle(PlainButtonStyle())

            // Center: AI Insight (✦/✨ in white circular button)
            Button(action: {
                #if os(iOS)
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                #endif
                onAiInsight()
            }) {
                Image(systemName: "sparkles")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(AppColors.accentCoral)
                    .frame(width: 50, height: 50)
                    .background(AppColors.surfaceWhite)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(AppColors.borderSubtle, lineWidth: 1)
                    )
                    .shadow(color: AppColors.subtleShadow, radius: 8, y: 3)
            }
            .buttonStyle(PlainButtonStyle())

            // Right: Like (♡ in Coral accent circle)
            Button(action: {
                #if os(iOS)
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                #endif
                onLike()
            }) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 68, height: 68)
                    .background(AppColors.accentCoral)
                    .clipShape(Circle())
                    .shadow(color: AppColors.buttonShadow, radius: 14, y: 6)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    FloatingActionBar(onPass: {}, onAiInsight: {}, onLike: {})
        .padding()
        .background(AppColors.backgroundWarm)
}
