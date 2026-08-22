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
                            colors: [Color.clear, AppColors.backgroundWarm.opacity(0.95), AppColors.backgroundWarm],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 110)
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
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                            .padding(10)
                            .background(AppColors.surfaceWhite)
                            .clipShape(Circle())
                            .shadow(color: AppColors.subtleShadow, radius: 4, y: 2)
                    }
                } else {
                    Spacer().frame(width: 36)
                }

                Spacer()

                HStack(spacing: 4) {
                    Text("SoulAI")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundColor(AppColors.textPrimary)
                    Circle()
                        .fill(AppColors.accentCoral)
                        .frame(width: 5, height: 5)
                }

                Spacer()

                Text("\(viewModel.currentStep.rawValue + 1) of 5")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(AppColors.surfaceNeutral)
                    .clipShape(Capsule())
            }

            // Step Progress Track
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(AppColors.borderSubtle)
                        .frame(height: 3)

                    Capsule()
                        .fill(AppColors.accentCoral)
                        .frame(width: geo.size.width * CGFloat(viewModel.currentStep.rawValue + 1) / 5.0, height: 3)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.currentStep)
                }
            }
            .frame(height: 3)
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
            VStack(alignment: .leading, spacing: 6) {
                Text("Let's begin with you")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                Text("SoulAI helps people connect through genuine personality.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
            }

            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("FIRST NAME")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)
                    TextField("Your name", text: $viewModel.name)
                        .font(.system(size: 17))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(14)
                        .background(AppColors.surfaceWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppColors.borderSubtle, lineWidth: 1))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("AGE")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)
                    Stepper(value: $viewModel.age, in: 18...80) {
                        Text("\(viewModel.age) years old")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(AppColors.textPrimary)
                    }
                    .padding(12)
                    .background(AppColors.surfaceWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppColors.borderSubtle, lineWidth: 1))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("OCCUPATION")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)
                    TextField("e.g. Product Designer", text: $viewModel.occupation)
                        .font(.system(size: 16))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(14)
                        .background(AppColors.surfaceWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppColors.borderSubtle, lineWidth: 1))
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("LOCATION")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)
                    TextField("e.g. San Francisco", text: $viewModel.location)
                        .font(.system(size: 16))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(14)
                        .background(AppColors.surfaceWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppColors.borderSubtle, lineWidth: 1))
                }
            }
        }
    }

    // MARK: - Step 2: Interests
    private var interestsStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("What moves you?")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                Text("Select at least 2 interests you love exploring.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
            }

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
            .padding(16)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppColors.borderSubtle, lineWidth: 1))
        }
    }

    // MARK: - Step 3: Personality Traits
    private var personalityTraitsStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Your essence")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                Text("Pick traits that define how you connect with others.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
            }

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
            .padding(16)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppColors.borderSubtle, lineWidth: 1))
        }
    }

    // MARK: - Step 4: Dating Intention
    private var intentionStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Your intention")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                Text("Clear intentions lead to meaningful connections.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
            }

            VStack(spacing: 10) {
                ForEach(DatingIntention.allCases) { intention in
                    Button(action: {
                        viewModel.selectedIntention = intention
                    }) {
                        HStack(spacing: 14) {
                            Image(systemName: intention.iconName)
                                .font(.system(size: 18))
                                .foregroundColor(viewModel.selectedIntention == intention ? .white : AppColors.accentCoral)
                                .frame(width: 38, height: 38)
                                .background(
                                    Circle()
                                        .fill(viewModel.selectedIntention == intention ? Color.white.opacity(0.2) : AppColors.softPeach)
                                )

                            Text(intention.rawValue)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(viewModel.selectedIntention == intention ? .white : AppColors.textPrimary)

                            Spacer()

                            if viewModel.selectedIntention == intention {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .bold))
                            }
                        }
                        .padding(16)
                        .background(
                            viewModel.selectedIntention == intention ? AppColors.accentCoral : AppColors.surfaceWhite
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(AppColors.borderSubtle, lineWidth: 1)
                        )
                        .shadow(color: viewModel.selectedIntention == intention ? AppColors.buttonShadow : AppColors.subtleShadow, radius: 6, y: 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }

    // MARK: - Step 5: Synthesis Summary
    private var aiSynthesisStep: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Your Profile")
                    .font(.system(size: 32, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                Text("Ready to discover meaningful connections.")
                    .font(.system(size: 15))
                    .foregroundColor(AppColors.textSecondary)
            }

            if viewModel.isSynthesizing {
                VStack(spacing: 16) {
                    ProgressView()
                        .tint(AppColors.accentCoral)
                        .scaleEffect(1.2)
                    Text("Understanding your personality essence...")
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textSecondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(AppColors.surfaceWhite)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            } else {
                VStack(alignment: .leading, spacing: 14) {
                    Text("ESSENCE")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)

                    Text("\"\(viewModel.soulVibeSummary.isEmpty ? "Creative explorer seeking genuine conversations and slow Sunday coffee rituals." : viewModel.soulVibeSummary)\"")
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .foregroundColor(AppColors.textPrimary)
                        .italic()
                        .lineSpacing(4)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(AppColors.softPeach)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
        }
    }

    // MARK: - Bottom CTA Bar
    private var bottomBar: some View {
        SoulButton(
            title: viewModel.currentStep == .aiSynthesis ? "Enter SoulAI" : "Continue",
            iconName: viewModel.currentStep == .aiSynthesis ? "heart.fill" : "arrow.right",
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

#Preview {
    OnboardingView()
        .environment(AppState())
}
