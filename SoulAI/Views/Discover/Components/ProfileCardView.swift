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
                // Full Bleed Portrait Image Canvas
                portraitImageView(height: geo.size.height)

                // Subtle Vignette Overlay for Text Readability
                AppColors.photoOverlayGradient
                    .frame(height: geo.size.height * 0.55)

                // Bottom Content Overlay
                VStack(alignment: .leading, spacing: 14) {
                    // Header Line: Name & Compatibility Pill
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("\(profile.name), \(profile.age)")
                                .font(.system(size: 30, weight: .bold, design: .serif))
                                .foregroundColor(.white)

                            Text("\(profile.occupation) • \(profile.location)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color.white.opacity(0.85))
                        }

                        Spacer()

                        // Compatibility Pill
                        HStack(spacing: 4) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(AppColors.accentCoral)
                            Text("\(profile.compatibilityScore)% match")
                                .font(.system(size: 13, weight: .bold, design: .rounded))
                                .foregroundColor(AppColors.textPrimary)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.95))
                        .clipShape(Capsule())
                    }

                    // Elegant Quote (Instead of bio paragraph)
                    Text("\"\(profile.quote)\"")
                        .font(.system(size: 16, weight: .medium, design: .serif))
                        .foregroundColor(Color.white.opacity(0.95))
                        .italic()
                        .lineSpacing(3)

                    // 3-4 Personality Tags
                    HStack(spacing: 8) {
                        ForEach(profile.tags.prefix(4), id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(22)
            }
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusHeroCard, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignTokens.cornerRadiusHeroCard, style: .continuous)
                    .stroke(Color.black.opacity(0.04), lineWidth: 1)
            )
            .shadow(color: AppColors.subtleShadow, radius: 14, x: 0, y: 6)
            .onTapGesture {
                onOpenDetail()
            }
        }
    }

    // MARK: - Portrait Visual View
    @ViewBuilder
    private func portraitImageView(height: CGFloat) -> some View {
        ZStack {
            // Warm Editorial Palette Canvas
            LinearGradient(
                colors: [
                    Color(hex: profile.photoGradientStartHex),
                    Color(hex: profile.photoGradientEndHex)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // Warm Ambient Glow in Center
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 260, height: 260)
                .blur(radius: 40)
                .offset(y: -40)

            // Editorial Portrait Monogram / Icon
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.18))
                        .frame(width: 110, height: 110)

                    Text(String(profile.name.prefix(1)))
                        .font(.system(size: 52, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                }
                .shadow(color: Color.black.opacity(0.15), radius: 10, y: 5)
                .padding(.top, 40)

                Spacer()
            }
        }
    }
}

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (255, 90, 122)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

#Preview {
    ProfileCardView(profile: MockDataProvider.sampleMatches[0], onOpenDetail: {})
        .frame(height: 540)
        .padding()
}
