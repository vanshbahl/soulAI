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

    @State private var isPulsing: Bool = false

    public init(score: Int, size: BadgeSize = .medium, showSparkle: Bool = true) {
        self.score = score
        self.size = size
        self.showSparkle = showSparkle
    }

    public var body: some View {
        HStack(spacing: spacing) {
            if showSparkle {
                Image(systemName: "sparkles")
                    .font(.system(size: iconSize, weight: .bold))
                    .foregroundColor(AppColors.auroraTeal)
                    .symbolEffect(.pulse, options: .repeating)
            }

            Text("\(score)%")
                .font(.system(size: fontSize, weight: .black, design: .rounded))
                .foregroundColor(.white)

            if size == .large {
                Text("Soul Match")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white.opacity(0.85))
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .background(
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            AppColors.primaryRose.opacity(0.85),
                            AppColors.electricViolet.opacity(0.9)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay(
                    Capsule()
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.6), AppColors.auroraTeal.opacity(0.4)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .shadow(color: AppColors.primaryRose.opacity(0.4), radius: isPulsing ? 12 : 6, x: 0, y: 3)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                isPulsing = true
            }
        }
    }

    private var fontSize: CGFloat {
        switch size {
        case .small: return 12
        case .medium: return 15
        case .large: return 20
        }
    }

    private var iconSize: CGFloat {
        switch size {
        case .small: return 10
        case .medium: return 12
        case .large: return 16
        }
    }

    private var spacing: CGFloat {
        switch size {
        case .small: return 4
        case .medium: return 6
        case .large: return 8
        }
    }

    private var horizontalPadding: CGFloat {
        switch size {
        case .small: return 8
        case .medium: return 12
        case .large: return 18
        }
    }

    private var verticalPadding: CGFloat {
        switch size {
        case .small: return 4
        case .medium: return 7
        case .large: return 10
        }
    }
}
