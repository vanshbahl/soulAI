import SwiftUI

public struct OnboardingView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = OnboardingViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(spacing: 0) {
                // Top Progress Bar & Header
                headerView
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 24)

                // Current Step Content Container
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        stepContent
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 120)
                }

                Spacer()
            }

            // Bottom Floating CTA Bar
            VStack {
                Spacer()
                bottomBar
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    .background(
                        LinearGradient(
                            colors: [Color.clear, AppColors.backgroundDark.opacity(0.95), AppColors.backgroundDark],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 120)
                        .allowsHitTesting(false)
                    )
            }
        }
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                if viewModel.currentStep != .basicInfo {
                    Button(action: { viewModel.previousStep() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                } else {
                    Spacer().frame(width: 36)
                }

                Spacer()

                HStack(spacing: 6) {
                    Image(systemName: "sparkles")
                        .foregroundColor(AppColors.primaryRose)
                    Text("SoulAI")
                        .font(.system(size: 18, weight: .black, design: .rounded))
                        .foregroundStyle(AppColors.soulGradient)
                }

                Spacer()

                // Step counter
                Text("\(viewModel.currentStep.rawValue + 1)/5")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.softLilac)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.08))
                    .clipShape(Capsule())
            }

            // Step Progress Track
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.12))
                        .frame(height: 4)

                    Capsule()
                        .fill(AppColors.soulGradient)
                        .frame(width: geo.size.width * CGFloat(viewModel.currentStep.rawValue + 1) / 5.0, height: 4)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.currentStep)
                }
            }
            .frame(height: 4)
        }
    }

    // MARK: - Step Content Switcher
    @ViewBuilder
    private var stepContent: some View {
        switch viewModel.currentStep {
        case .basicInfo:
            basicInfoStep
        case .interests:
            interestsStep
        case .personalityTraits:
            personalityTraitsStep
        case .intention:
            intentionStep
        case .aiSynthesis:
            aiSynthesisStep
        }
    }

    // MARK: - Step 1: Basic Info
    private var basicInfoStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome to SoulAI")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("Let's create your AI-augmented soul profile.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.subtleText)
            }

            GlassCard {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("YOUR FIRST NAME")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppColors.softLilac)
                        TextField("e.g. Alex", text: $viewModel.name)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("AGE")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppColors.softLilac)
                        Stepper(value: $viewModel.age, in: 18...80) {
                            Text("\(viewModel.age) years old")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("OCCUPATION / CRAFT")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppColors.softLilac)
                        TextField("e.g. Product Designer & Stargazer", text: $viewModel.occupation)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("LOCATION")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppColors.softLilac)
                        TextField("e.g. San Francisco, CA", text: $viewModel.location)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                    }
                }
            }
        }
    }

    // MARK: - Step 2: Interests
    private var interestsStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("What sparks your curiosity?")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("Select at least 2 interests to train the neural matching engine.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.subtleText)
            }

            GlassCard {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 10)], spacing: 10) {
                    ForEach(viewModel.availableInterests, id: \.self) { interest in
                        TagPillView(
                            title: interest,
                            isSelected: viewModel.selectedInterests.contains(interest),
                            isSelectable: true
                        ) {
                            viewModel.toggleInterest(interest)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Step 3: Personality Traits
    private var personalityTraitsStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Describe your essence")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("Choose 2 or more traits that define how you connect and create.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.subtleText)
            }

            GlassCard {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 10)], spacing: 10) {
                    ForEach(viewModel.availableTraits, id: \.self) { trait in
                        TagPillView(
                            title: trait,
                            isSelected: viewModel.selectedTraits.contains(trait),
                            isSelectable: true
                        ) {
                            viewModel.toggleTrait(trait)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Step 4: Dating Intention
    private var intentionStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("What are you seeking?")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("SoulAI aligns expectations so connections are genuine and mutual.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.subtleText)
            }

            VStack(spacing: 12) {
                ForEach(DatingIntention.allCases) { intention in
                    Button(action: {
                        viewModel.selectedIntention = intention
                    }) {
                        HStack(spacing: 16) {
                            Image(systemName: intention.iconName)
                                .font(.system(size: 22))
                                .foregroundColor(viewModel.selectedIntention == intention ? .white : AppColors.primaryRose)
                                .frame(width: 44, height: 44)
                                .background(
                                    Circle()
                                        .fill(viewModel.selectedIntention == intention ? Color.white.opacity(0.2) : Color.white.opacity(0.08))
                                )

                            VStack(alignment: .leading, spacing: 4) {
                                Text(intention.rawValue)
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }

                            Spacer()

                            if viewModel.selectedIntention == intention {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(AppColors.auroraTeal)
                                    .font(.system(size: 20))
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(viewModel.selectedIntention == intention ? AnyShapeStyle(AppColors.soulGradient.opacity(0.85)) : AnyShapeStyle(Color.white.opacity(0.07)))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(viewModel.selectedIntention == intention ? Color.white.opacity(0.5) : Color.white.opacity(0.1), lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }

    // MARK: - Step 5: AI Synthesis Preview
    private var aiSynthesisStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "wand.and.stars")
                        .foregroundColor(AppColors.auroraTeal)
                    Text("AI Profile Synthesis")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                Text("Your personalized neural bio and resonance vectors.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.subtleText)
            }

            if viewModel.isSynthesizing {
                GlassCard {
                    VStack(spacing: 20) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: AppColors.auroraTeal))
                            .scaleEffect(1.4)
                            .padding(.top, 10)

                        Text("Synthesizing personality insights & resonance bio...")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        ProgressView(value: viewModel.synthesisProgress)
                            .tint(AppColors.primaryRose)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                }
            } else {
                // Generated Bio Card
                GlassCard {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(AppColors.primaryRose)
                            Text("GENERATED SOUL BIO")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(AppColors.softLilac)
                            Spacer()
                            Button(action: { viewModel.startAISynthesis() }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "arrow.clockwise")
                                    Text("Regenerate")
                                }
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(AppColors.auroraTeal)
                            }
                        }

                        Text(viewModel.generatedBio)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white.opacity(0.92))
                            .lineSpacing(4)
                    }
                }

                // Generated Insights
                VStack(spacing: 10) {
                    ForEach(viewModel.generatedInsights) { insight in
                        GlassCard(padding: 12) {
                            HStack(spacing: 12) {
                                Image(systemName: insight.icon)
                                    .font(.system(size: 18))
                                    .foregroundColor(AppColors.auroraTeal)
                                    .frame(width: 36, height: 36)
                                    .background(Color.white.opacity(0.08))
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(insight.title)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                    Text(insight.explanation)
                                        .font(.system(size: 12))
                                        .foregroundColor(AppColors.subtleText)
                                        .lineLimit(2)
                                }

                                Spacer()

                                CompatibilityBadge(score: insight.score, size: .small, showSparkle: false)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Bottom CTA Bar
    private var bottomBar: some View {
        SoulButton(
            title: viewModel.currentStep == .aiSynthesis ? "Launch SoulAI ✨" : "Continue",
            iconName: viewModel.currentStep == .aiSynthesis ? "sparkles" : "arrow.right",
            style: .primaryGradient
        ) {
            if viewModel.currentStep == .aiSynthesis {
                let profile = viewModel.buildProfile()
                appState.completeOnboarding(profile: profile)
            } else {
                viewModel.nextStep()
            }
        }
        .disabled(!viewModel.canProceed)
        .opacity(viewModel.canProceed ? 1.0 : 0.5)
    }
}
