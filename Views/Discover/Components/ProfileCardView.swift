import SwiftUI

public struct ProfileCardView: View {
    let profile: MatchProfile
    let onOpenDetail: () -> Void

    public init(profile: MatchProfile, onOpenDetail: @escaping () -> Void) {
        self.profile = profile
        self.onOpenDetail = onOpenDetail
    }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                // Card Background & Dynamic Visual Gradient
                cardVisualHeader(height: geo.size.height)

                // Bottom Content Glass Panel
                VStack(alignment: .leading, spacing: 14) {
                    // Name, Age, Distance & Compatibility Badge
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 8) {
                                Text(profile.name)
                                    .font(.system(size: 26, weight: .black, design: .rounded))
                                    .foregroundColor(.white)

                                Text("\(profile.age)")
                                    .font(.system(size: 22, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.white.opacity(0.85))

                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                            }

                            HStack(spacing: 6) {
                                Image(systemName: "briefcase.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(AppColors.softLilac)
                                Text(profile.occupation)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white.opacity(0.85))
                                    .lineLimit(1)
                            }

                            HStack(spacing: 4) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 11))
                                    .foregroundColor(AppColors.auroraTeal)
                                Text("\(profile.location) • \(profile.distanceMiles) miles away")
                                    .font(.system(size: 12))
                                    .foregroundColor(AppColors.subtleText)
                            }
                        }

                        Spacer()

                        CompatibilityBadge(score: profile.compatibilityScore, size: .medium)
                    }

                    // AI Bio Preview
                    Text(profile.aiGeneratedBio)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color.white.opacity(0.9))
                        .lineLimit(2)
                        .lineSpacing(2)

                    // AI Match Reasons Highlight Box
                    VStack(alignment: .leading, spacing: 6) {
                        HStack(spacing: 5) {
                            Image(systemName: "wand.and.stars")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(AppColors.auroraTeal)
                            Text("WHY SOULAI MATCHED YOU")
                                .font(.system(size: 10, weight: .black, design: .rounded))
                                .foregroundColor(AppColors.auroraTeal)
                        }

                        if let firstReason = profile.matchReasons.first {
                            HStack(alignment: .top, spacing: 6) {
                                Text("•")
                                    .foregroundColor(AppColors.primaryRose)
                                    .font(.system(size: 14, weight: .bold))
                                Text(firstReason)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white.opacity(0.85))
                                    .lineLimit(2)
                            }
                        }
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.06))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AppColors.auroraTeal.opacity(0.2), lineWidth: 1)
                    )

                    // Tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(profile.interests.prefix(3), id: \.self) { interest in
                                TagPillView(title: interest)
                            }
                        }
                    }

                    // Info / Deep Analysis Button
                    Button(action: onOpenDetail) {
                        HStack {
                            Image(systemName: "sparkles.rectangle.stack")
                                .font(.system(size: 12, weight: .bold))
                            Text("View Full Compatibility Breakdown")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 11, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.white.opacity(0.1))
                        .clipShape(Capsule())
                    }
                }
                .padding(18)
                .background(
                    RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusLarge, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            LinearGradient(
                                colors: [
                                    Color.black.opacity(0.0),
                                    Color.black.opacity(0.7)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusLarge, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusLarge, style: .continuous)
                    .stroke(
                        LinearGradient(
                            colors: [Color.white.opacity(0.3), Color.white.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.2
                    )
            )
            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 10)
        }
    }

    @ViewBuilder
    private func cardVisualHeader(height: CGFloat) -> some View {
        ZStack {
            // Stylized Generative Visual Background
            gradientForTheme(profile.gradientThemeName)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 140, height: 140)
                        .blur(radius: 20)

                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 120, height: 120)

                    Image(systemName: profile.avatarSymbol)
                        .font(.system(size: 58))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.top, 40)

                HStack(spacing: 6) {
                    ForEach(profile.vibeKeywords, id: \.self) { vibe in
                        Text("#\(vibe)")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundColor(Color.white.opacity(0.85))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.black.opacity(0.25))
                            .clipShape(Capsule())
                    }
                }

                Spacer()
            }
        }
    }

    private func gradientForTheme(_ theme: String) -> LinearGradient {
        switch theme {
        case "rose":
            return LinearGradient(
                colors: [AppColors.primaryRose, AppColors.electricViolet, AppColors.cardSurface],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "violet":
            return LinearGradient(
                colors: [AppColors.electricViolet, Color(red: 0.2, green: 0.1, blue: 0.5), AppColors.cardSurface],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "teal":
            return LinearGradient(
                colors: [AppColors.auroraTeal.opacity(0.8), AppColors.electricViolet, AppColors.cardSurface],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            return LinearGradient(
                colors: [AppColors.sunsetAmber, AppColors.primaryRose, AppColors.cardSurface],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
