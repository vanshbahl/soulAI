import SwiftUI

public struct DatingCoachView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = DatingCoachViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(spacing: 0) {
                // Header
                headerView
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Category Selector Chips
                        categorySelector

                        // Suggested Quick Prompts Grid
                        quickPromptsSection

                        // Actionable Advice Cards Carousel
                        adviceCardsSection

                        // Coach Conversation Stream
                        coachChatSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }

                // Bottom Question Input
                coachInputBar
            }
        }
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Image(systemName: "wand.and.stars")
                        .foregroundColor(AppColors.auroraTeal)
                    Text("AI Dating Coach")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                Text("Real-time emotional intelligence & conversation guidance")
                    .font(.system(size: 13))
                    .foregroundColor(AppColors.subtleText)
            }
            Spacer()
        }
    }

    // MARK: - Category Selector
    private var categorySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { index, category in
                    TagPillView(
                        title: category.title,
                        icon: category.icon,
                        isSelected: viewModel.selectedCategoryIndex == index,
                        isSelectable: true
                    ) {
                        viewModel.selectCategory(index: index)
                    }
                }
            }
        }
    }

    // MARK: - Quick Prompts
    private var quickPromptsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SUGGESTED PROMPTS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.softLilac)

            VStack(spacing: 8) {
                ForEach(viewModel.currentCategory.prompts, id: \.self) { prompt in
                    Button(action: {
                        viewModel.askCoach(prompt: prompt)
                    }) {
                        HStack {
                            Image(systemName: "sparkles")
                                .font(.system(size: 12))
                                .foregroundColor(AppColors.primaryRose)
                            Text(prompt)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 11))
                                .foregroundColor(AppColors.subtleText)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.08), lineWidth: 1)
                        )
                    }
                }
            }
        }
    }

    // MARK: - Advice Cards
    private var adviceCardsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("RELATIONSHIP PLAYBOOKS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.softLilac)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(viewModel.adviceCards) { card in
                        GlassCard(cornerRadius: 18, padding: 14) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: card.icon)
                                        .foregroundColor(AppColors.auroraTeal)
                                    Text(card.category)
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(AppColors.auroraTeal)
                                }

                                Text(card.title)
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .lineLimit(2)

                                Text(card.summary)
                                    .font(.system(size: 12))
                                    .foregroundColor(AppColors.subtleText)
                                    .lineLimit(3)

                                VStack(alignment: .leading, spacing: 3) {
                                    ForEach(card.actionableSteps.prefix(2), id: \.self) { step in
                                        HStack(alignment: .top, spacing: 4) {
                                            Text("•").foregroundColor(AppColors.primaryRose)
                                            Text(step)
                                                .font(.system(size: 11))
                                                .foregroundColor(Color.white.opacity(0.85))
                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .frame(width: 240, alignment: .leading)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Coach Chat History
    private var coachChatSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("COACH SESSION")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.softLilac)

            VStack(spacing: 12) {
                ForEach(viewModel.coachMessages) { msg in
                    if msg.sender == .currentUser {
                        HStack {
                            Spacer()
                            Text(msg.content)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(12)
                                .background(AppColors.soulGradient)
                                .cornerRadius(16)
                        }
                    } else {
                        GlassCard(padding: 14) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "wand.and.stars")
                                        .foregroundColor(AppColors.auroraTeal)
                                    Text("SoulAI Coach")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(AppColors.auroraTeal)
                                }

                                Text(msg.content)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.95))
                                    .lineSpacing(4)

                                if !msg.aiSuggestedReplies.isEmpty {
                                    Divider().background(Color.white.opacity(0.1))
                                    Text("Follow-up questions:")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(AppColors.softLilac)

                                    VStack(alignment: .leading, spacing: 4) {
                                        ForEach(msg.aiSuggestedReplies, id: \.self) { reply in
                                            Button(action: {
                                                viewModel.askCoach(prompt: reply)
                                            }) {
                                                Text("→ \(reply)")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(AppColors.auroraTeal)
                                                    .multilineTextAlignment(.leading)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                if viewModel.isAnalyzing {
                    HStack {
                        ProgressView()
                            .tint(AppColors.auroraTeal)
                        Text("Coach is analyzing compatibility patterns...")
                            .font(.system(size: 12))
                            .foregroundColor(AppColors.subtleText)
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }

    // MARK: - Input Bar
    private var coachInputBar: some View {
        HStack(spacing: 10) {
            TextField("Ask your coach about messaging, dates, chemistry...", text: $viewModel.userQuestionInput)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.08))
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.12), lineWidth: 1)
                )

            Button(action: {
                viewModel.askCoach()
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(viewModel.userQuestionInput.isEmpty ? AnyShapeStyle(Color.white.opacity(0.2)) : AnyShapeStyle(AppColors.soulGradient))
            }
            .disabled(viewModel.userQuestionInput.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    DatingCoachView()
        .environment(AppState())
}
