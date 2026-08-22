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
                    VStack(alignment: .leading, spacing: 20) {
                        // Profile Banner Header
                        profileHeaderCard

                        // Overall Compatibility Gauge Card
                        compatibilityScoreCard

                        // Strengths & Synergy
                        strengthsSection

                        // Growth Areas & Challenges
                        challengesSection

                        // Dimension Breakdown
                        dimensionsSection

                        // AI Conversation Starters
                        conversationStartersSection

                        // Action Buttons
                        actionCTASection
                            .padding(.top, 10)
                            .padding(.bottom, 40)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
            .navigationTitle("Soul Compatibility")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(AppColors.subtleText)
                    }
                }
            }
        }
    }

    // MARK: - Profile Header
    private var profileHeaderCard: some View {
        GlassCard {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(AppColors.primaryRose.opacity(0.8))
                        .frame(width: 64, height: 64)
                    Image(systemName: match.avatarSymbol)
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(match.name)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("\(match.age)")
                            .font(.system(size: 18))
                            .foregroundColor(AppColors.softLilac)
                    }

                    Text(match.occupation)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))

                    Text("\(match.location) • \(match.distanceMiles) mi")
                        .font(.system(size: 12))
                        .foregroundColor(AppColors.subtleText)
                }

                Spacer()

                CompatibilityBadge(score: match.compatibilityScore, size: .large)
            }
        }
    }

    // MARK: - Compatibility Score & AI Tagline
    private var compatibilityScoreCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundColor(AppColors.auroraTeal)
                    Text("AI SYNERGY ANALYSIS")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.auroraTeal)
                }

                Text(match.analysis.matchTagline)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                Text(match.analysis.aiAdviceSummary)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(AppColors.subtleText)
                    .lineSpacing(3)
            }
        }
    }

    // MARK: - Strengths Section
    private var strengthsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "bolt.heart.fill")
                    .foregroundColor(AppColors.primaryRose)
                Text("Relationship Strengths")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }

            VStack(spacing: 8) {
                ForEach(match.analysis.strengths, id: \.self) { strength in
                    GlassCard(padding: 12) {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(AppColors.auroraTeal)
                                .font(.system(size: 14))
                                .padding(.top, 2)

                            Text(strength)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .lineSpacing(2)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Challenges Section
    private var challengesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "shield.lefthalf.filled")
                    .foregroundColor(AppColors.sunsetAmber)
                Text("Possible Growth Challenges")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }

            VStack(spacing: 8) {
                ForEach(match.analysis.possibleChallenges, id: \.self) { challenge in
                    GlassCard(padding: 12) {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(AppColors.sunsetAmber)
                                .font(.system(size: 14))
                                .padding(.top, 2)

                            Text(challenge)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                                .lineSpacing(2)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Dimension Breakdown
    private var dimensionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "chart.bar.xaxis")
                    .foregroundColor(AppColors.softLilac)
                Text("Compatibility Breakdown")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }

            GlassCard {
                VStack(spacing: 14) {
                    ForEach(match.analysis.dimensions) { dimension in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text(dimension.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)

                                Spacer()

                                Text("\(dimension.score)%")
                                    .font(.system(size: 13, weight: .black, design: .rounded))
                                    .foregroundColor(AppColors.auroraTeal)
                            }

                            // Progress Bar
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.white.opacity(0.1))
                                        .frame(height: 6)

                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [AppColors.primaryRose, AppColors.auroraTeal],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(width: geo.size.width * CGFloat(dimension.score) / 100.0, height: 6)
                                }
                            }
                            .frame(height: 6)

                            Text(dimension.detail)
                                .font(.system(size: 11))
                                .foregroundColor(AppColors.subtleText)
                        }
                        if dimension.id != match.analysis.dimensions.last?.id {
                            Divider().background(Color.white.opacity(0.1))
                        }
                    }
                }
            }
        }
    }

    // MARK: - Conversation Starters
    private var conversationStartersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "quote.bubble.fill")
                    .foregroundColor(AppColors.primaryRose)
                Text("AI Conversation Starters")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }

            VStack(spacing: 8) {
                ForEach(match.analysis.conversationStarters, id: \.self) { starter in
                    GlassCard(padding: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\"\(starter)\"")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.white.opacity(0.95))
                                    .italic()
                            }
                            Spacer()
                            Button(action: {
                                dismiss()
                                appState.selectedMatchForChat = match
                            }) {
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 13))
                                    .foregroundColor(AppColors.auroraTeal)
                                    .padding(8)
                                    .background(Color.white.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Action Buttons
    private var actionCTASection: some View {
        VStack(spacing: 12) {
            SoulButton(
                title: "Chat with \(match.name)",
                iconName: "bubble.left.and.bubble.right.fill",
                style: .primaryGradient
            ) {
                dismiss()
                appState.selectedMatchForChat = match
            }

            SoulButton(
                title: "Ask AI Dating Coach for Advice",
                iconName: "wand.and.stars",
                style: .secondaryGlass
            ) {
                dismiss()
                appState.selectedTab = .coach
            }
        }
    }
}

#Preview {
    MatchDetailView(match: MockDataProvider.sampleMatches[0])
        .environment(AppState())
}
