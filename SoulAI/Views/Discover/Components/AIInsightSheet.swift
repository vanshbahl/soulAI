import SwiftUI

public struct AIInsightSheet: View {
    @Environment(\.dismiss) private var dismiss
    let match: MatchProfile

    public init(match: MatchProfile) {
        self.match = match
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header with sparkle
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppColors.accentCoral)

                Text("Why you matched")
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)

                Spacer()

                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(AppColors.textMuted)
                }
            }
            .padding(.top, 8)

            // Personality Alignment Core Insight
            VStack(alignment: .leading, spacing: 10) {
                Text("\"\(match.emotionalInsight)\"")
                    .font(.system(size: 17, weight: .medium, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                    .italic()
                    .lineSpacing(4)

                Text("Your creative personalities align through curiosity, shared aesthetics, and thoughtful conversation.")
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.textSecondary)
                    .lineSpacing(3)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppColors.softPeach)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            // 3 Shared Points of Attraction
            VStack(alignment: .leading, spacing: 10) {
                Text("SHARED VIBES")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppColors.textSecondary)

                HStack(spacing: 8) {
                    ForEach(match.tags.prefix(3), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(AppColors.textPrimary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(AppColors.surfaceWhite)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(AppColors.borderSubtle, lineWidth: 1))
                    }
                }
            }

            Spacer()

            // Close button
            SoulButton(title: "Got it", style: .primaryGradient) {
                dismiss()
            }
            .padding(.bottom, 12)
        }
        .padding(24)
        .background(AppColors.backgroundWarm)
        .presentationDetents([.fraction(0.48)])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    AIInsightSheet(match: MockDataProvider.sampleMatches[0])
}
