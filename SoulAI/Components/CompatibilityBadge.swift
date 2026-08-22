import SwiftUI

public enum BadgeSize {
    case small
    case medium
    case large
}

public struct CompatibilityBadge: View {
    let score: Int
    let size: BadgeSize
    let showSparkle: Bool

    public init(score: Int, size: BadgeSize = .medium, showSparkle: Bool = true) {
        self.score = score
        self.size = size
        self.showSparkle = showSparkle
    }

    public var body: some View {
        HStack(spacing: 5) {
            if showSparkle {
                Image(systemName: "sparkles")
                    .font(.system(size: iconSize, weight: .bold))
                    .foregroundColor(AppColors.accentCoral)
            }

            Text("\(score)% match")
                .font(.system(size: fontSize, weight: .semibold, design: .rounded))
                .foregroundColor(AppColors.textPrimary)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .background(AppColors.surfaceWhite.opacity(0.95))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(AppColors.borderSubtle, lineWidth: 1)
        )
        .shadow(color: AppColors.subtleShadow, radius: 4, x: 0, y: 2)
    }

    private var fontSize: CGFloat {
        switch size {
        case .small: return 12
        case .medium: return 13
        case .large: return 15
        }
    }

    private var iconSize: CGFloat {
        switch size {
        case .small: return 10
        case .medium: return 11
        case .large: return 13
        }
    }

    private var horizontalPadding: CGFloat {
        switch size {
        case .small: return 8
        case .medium: return 12
        case .large: return 14
        }
    }

    private var verticalPadding: CGFloat {
        switch size {
        case .small: return 4
        case .medium: return 6
        case .large: return 8
        }
    }
}
