import SwiftUI

public struct PremiumProfileCard: View {
    let profile: MatchProfile
    let onAiInsightTap: () -> Void
    let onCardTap: () -> Void

    public init(profile: MatchProfile, onAiInsightTap: @escaping () -> Void, onCardTap: @escaping () -> Void) {
        self.profile = profile
        self.onAiInsightTap = onAiInsightTap
        self.onCardTap = onCardTap
    }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                // Full Bleed Portrait Image
                portraitCanvas(width: geo.size.width, height: geo.size.height)

                // Dark Transparent Gradient Overlay strictly at the bottom
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.black.opacity(0.1),
                        Color.black.opacity(0.65),
                        Color.black.opacity(0.92)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: geo.size.height * 0.58)

                // Profile Overlay (Bottom Left)
                VStack(alignment: .leading, spacing: 12) {
                    // Floating "✨ Why we matched" Pill Button
                    Button(action: {
                        #if os(iOS)
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        #endif
                        onAiInsightTap()
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(AppColors.accentCoral)
                            Text("Why we matched")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.45))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule().stroke(Color.white.opacity(0.25), lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())

                    // Large Name & Age (34-40pt Bold SF Pro)
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(profile.name)
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            .foregroundColor(.white)

                        Text("\(profile.age)")
                            .font(.system(size: 32, weight: .light, design: .rounded))
                            .foregroundColor(Color.white.opacity(0.85))
                    }

                    // Metadata: "Architect • San Francisco"
                    HStack(spacing: 6) {
                        Text(profile.occupation)
                            .font(.system(size: 15, weight: .medium))
                        Text("•")
                            .font(.system(size: 14))
                        Text(profile.location)
                            .font(.system(size: 15, weight: .medium))
                    }
                    .foregroundColor(Color.white.opacity(0.9))

                    // One Emotional Sentence (Not a biography, not an AI explanation)
                    Text("\"\(profile.quote)\"")
                        .font(.system(size: 16, weight: .medium, design: .serif))
                        .foregroundColor(Color.white.opacity(0.95))
                        .italic()
                        .lineSpacing(3)

                    // Small Pill Tags (3-4 tags)
                    HStack(spacing: 8) {
                        ForEach(profile.tags.prefix(3), id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.white.opacity(0.18))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(.top, 2)
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 24)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .stroke(AppColors.borderSubtle, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.08), radius: 18, x: 0, y: 8)
            .onTapGesture {
                onCardTap()
            }
        }
    }

    // MARK: - Portrait Canvas
    @ViewBuilder
    private func portraitCanvas(width: CGFloat, height: CGFloat) -> some View {
        ZStack {
            // Warm Photographic Color Palette
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
                .fill(Color.white.opacity(0.15))
                .frame(width: width * 0.7, height: width * 0.7)
                .blur(radius: 50)
                .offset(y: -40)

            // Minimalist Portrait Monogram Feature
            VStack {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.16))
                        .frame(width: 120, height: 120)

                    Text(String(profile.name.prefix(1)))
                        .font(.system(size: 58, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                }
                .padding(.top, 70)

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
        case 6:
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
    PremiumProfileCard(
        profile: MockDataProvider.sampleMatches[0],
        onAiInsightTap: {},
        onCardTap: {}
    )
    .frame(height: 580)
    .padding()
}
