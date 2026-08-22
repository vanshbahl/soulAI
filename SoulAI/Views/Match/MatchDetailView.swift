import SwiftUI

public struct MatchDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    let match: MatchProfile

    public init(match: MatchProfile) {
        self.match = match
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                BackgroundAtmosphereView()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        // Hero Photo Header
                        heroHeaderCard

                        // Emotional Insight Box
                        insightBox

                        // About & Tags
                        tagsSection

                        // Shared Strengths
                        strengthsSection

                        // Suggested Conversation Starters
                        startersSection

                        // CTA Button
                        SoulButton(
                            title: "Start Conversation with \(match.name)",
                            iconName: "bubble.left.fill",
                            style: .primaryGradient
                        ) {
                            dismiss()
                            appState.selectedMatchForChat = match
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
            .navigationTitle("Profile")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(AppColors.textMuted)
                    }
                }
            }
        }
    }

    // MARK: - Hero Header
    private var heroHeaderCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack(alignment: .bottomLeading) {
                LinearGradient(
                    colors: [Color(hex: match.photoGradientStartHex), Color(hex: match.photoGradientEndHex)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 280)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    Text(String(match.name.prefix(1)))
                        .font(.system(size: 72, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                )

                // Compatibility Pill Overlay
                HStack(spacing: 4) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.accentCoral)
                    Text("\(match.compatibilityScore)% match")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundColor(AppColors.textPrimary)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(Color.white.opacity(0.95))
                .clipShape(Capsule())
                .padding(16)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(match.name), \(match.age)")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)

                Text("\(match.occupation) • \(match.location)")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(.horizontal, 4)
        }
    }

    // MARK: - Emotional Insight Box
    private var insightBox: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 5) {
                Image(systemName: "sparkles")
                    .foregroundColor(AppColors.accentCoral)
                    .font(.system(size: 13))
                Text("WHY YOU MATCH")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppColors.accentCoral)
            }

            Text("\"\(match.emotionalInsight)\"")
                .font(.system(size: 16, weight: .medium, design: .serif))
                .foregroundColor(AppColors.textPrimary)
                .italic()
                .lineSpacing(3)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColors.softPeach)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    // MARK: - Tags Section
    private var tagsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("INTERESTS & ESSENCE")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(match.tags, id: \.self) { tag in
                        TagPillView(title: tag)
                    }
                }
            }
        }
    }

    // MARK: - Strengths Section
    private var strengthsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("RELATIONSHIP SYNERGY")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            VStack(spacing: 8) {
                ForEach(match.analysis.strengths, id: \.self) { strength in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(AppColors.accentCoral)
                            .padding(.top, 3)

                        Text(strength)
                            .font(.system(size: 14))
                            .foregroundColor(AppColors.textPrimary)
                            .lineSpacing(2)
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(AppColors.surfaceWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppColors.borderSubtle, lineWidth: 1))
                }
            }
        }
    }

    // MARK: - Starters Section
    private var startersSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("CONVERSATION STARTERS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            VStack(spacing: 8) {
                ForEach(match.analysis.conversationStarters, id: \.self) { starter in
                    Button(action: {
                        dismiss()
                        appState.selectedMatchForChat = match
                    }) {
                        HStack {
                            Text("\"\(starter)\"")
                                .font(.system(size: 14, weight: .medium, design: .serif))
                                .foregroundColor(AppColors.textPrimary)
                                .italic()
                                .multilineTextAlignment(.leading)

                            Spacer()

                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 12))
                                .foregroundColor(AppColors.accentCoral)
                        }
                        .padding(14)
                        .background(AppColors.surfaceWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppColors.borderSubtle, lineWidth: 1))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
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
    MatchDetailView(match: MockDataProvider.sampleMatches[0])
        .environment(AppState())
}
