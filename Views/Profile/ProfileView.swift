import SwiftUI

public struct ProfileView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = ProfileViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Profile Header Card
                    profileHeaderCard

                    // AI Soul Bio Card with Tone Switcher
                    aiBioCard

                    // Personality Insights
                    personalityInsightsSection

                    // Interests & Traits
                    interestsAndTraitsSection

                    // Settings & Demo Reset
                    demoActionsSection
                        .padding(.top, 10)
                        .padding(.bottom, 120)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
            }
        }
        .onAppear {
            viewModel.user = appState.currentUser
        }
    }

    // MARK: - Profile Header Card
    private var profileHeaderCard: some View {
        GlassCard {
            VStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(AppColors.soulGradient)
                        .frame(width: 90, height: 90)
                        .overlay(
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                        )
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.4), lineWidth: 2)
                        )
                }
                .shadow(color: AppColors.primaryRose.opacity(0.4), radius: 12)

                VStack(spacing: 4) {
                    HStack(spacing: 8) {
                        Text(viewModel.user.name)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Text("\(viewModel.user.age)")
                            .font(.system(size: 20))
                            .foregroundColor(AppColors.softLilac)
                    }

                    Text(viewModel.user.occupation)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.85))

                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 11))
                            .foregroundColor(AppColors.auroraTeal)
                        Text(viewModel.user.location)
                            .font(.system(size: 12))
                            .foregroundColor(AppColors.subtleText)
                    }
                }

                // Soul Vibe Summary Capsule
                HStack(spacing: 6) {
                    Image(systemName: "wand.and.stars")
                        .foregroundColor(AppColors.auroraTeal)
                        .font(.system(size: 12))
                    Text(viewModel.user.soulVibeSummary)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.06))
                .clipShape(Capsule())
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - AI Generated Bio Card
    private var aiBioCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                            .foregroundColor(AppColors.primaryRose)
                        Text("AI-GENERATED BIO")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppColors.softLilac)
                    }
                    Spacer()

                    if viewModel.isRegeneratingBio {
                        ProgressView()
                            .tint(AppColors.auroraTeal)
                            .scaleEffect(0.8)
                    }
                }

                Text(viewModel.user.aiGeneratedBio)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.white.opacity(0.92))
                    .lineSpacing(4)

                Divider().background(Color.white.opacity(0.1))

                // Bio Tone Selector
                VStack(alignment: .leading, spacing: 8) {
                    Text("Regenerate tone with AI:")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.subtleText)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(BioToneStyle.allCases) { tone in
                                TagPillView(
                                    title: tone.rawValue,
                                    isSelected: viewModel.selectedBioTone == tone,
                                    isSelectable: true
                                ) {
                                    viewModel.regenerateBio(tone: tone)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Personality Insights
    private var personalityInsightsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "brain.head.profile")
                    .foregroundColor(AppColors.auroraTeal)
                Text("Personality Insights")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }

            VStack(spacing: 10) {
                ForEach(viewModel.user.personalityInsights) { insight in
                    GlassCard(padding: 14) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: insight.icon)
                                    .font(.system(size: 16))
                                    .foregroundColor(AppColors.auroraTeal)

                                Text(insight.title)
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)

                                Spacer()

                                CompatibilityBadge(score: insight.score, size: .small, showSparkle: false)
                            }

                            Text(insight.explanation)
                                .font(.system(size: 12))
                                .foregroundColor(AppColors.subtleText)
                                .lineSpacing(2)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Interests & Traits
    private var interestsAndTraitsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("INTERESTS")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppColors.softLilac)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.user.interests, id: \.self) { interest in
                            TagPillView(title: interest)
                        }
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("ESSENCE TRAITS")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(AppColors.softLilac)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.user.traits, id: \.self) { trait in
                            TagPillView(title: trait)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Demo Actions
    private var demoActionsSection: some View {
        VStack(spacing: 12) {
            SoulButton(
                title: "Restart Onboarding Flow (Demo)",
                iconName: "arrow.counterclockwise",
                style: .secondaryGlass
            ) {
                appState.restartOnboarding()
            }
        }
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
}
