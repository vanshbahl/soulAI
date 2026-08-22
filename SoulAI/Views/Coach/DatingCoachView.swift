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
                    .padding(.top, 16)
                    .padding(.bottom, 12)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Quick Conversation Prompts
                        quickPromptsSection

                        // Relationship Playbook Cards
                        playbooksSection

                        // Coach Session Messages
                        coachChatSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }

                // Chat Input at Bottom
                coachInputBar
            }
        }
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Your Dating Companion")
                .font(.system(size: 32, weight: .bold, design: .serif))
                .foregroundColor(AppColors.textPrimary)

            Text("Better conversations, naturally.")
                .font(.system(size: 15))
                .foregroundColor(AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Quick Prompts
    private var quickPromptsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("COMMON QUESTIONS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            VStack(spacing: 8) {
                quickPromptButton("Help me start a conversation")
                quickPromptButton("Make my reply more playful")
                quickPromptButton("Understand this message")
            }
        }
    }

    private func quickPromptButton(_ prompt: String) -> some View {
        Button(action: {
            viewModel.askCoach(prompt: prompt)
        }) {
            HStack {
                Image(systemName: "sparkles")
                    .font(.system(size: 12))
                    .foregroundColor(AppColors.accentCoral)

                Text(prompt)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textPrimary)

                Spacer()

                Image(systemName: "arrow.up.right")
                    .font(.system(size: 11))
                    .foregroundColor(AppColors.textMuted)
            }
            .padding(14)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(AppColors.borderSubtle, lineWidth: 1)
            )
            .shadow(color: AppColors.subtleShadow, radius: 4, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Playbooks Section
    private var playbooksSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("RELATIONSHIP PLAYBOOKS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.adviceCards) { card in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(card.category.uppercased())
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(AppColors.accentCoral)

                            Text(card.title)
                                .font(.system(size: 14, weight: .bold, design: .serif))
                                .foregroundColor(AppColors.textPrimary)
                                .lineLimit(2)

                            Text(card.summary)
                                .font(.system(size: 12))
                                .foregroundColor(AppColors.textSecondary)
                                .lineLimit(3)
                        }
                        .padding(14)
                        .frame(width: 220, alignment: .leading)
                        .background(AppColors.surfaceWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(AppColors.borderSubtle, lineWidth: 1)
                        )
                        .shadow(color: AppColors.subtleShadow, radius: 6, y: 2)
                    }
                }
            }
        }
    }

    // MARK: - Coach Chat Stream
    private var coachChatSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SESSION")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            VStack(spacing: 12) {
                ForEach(viewModel.coachMessages) { msg in
                    if msg.sender == .currentUser {
                        HStack {
                            Spacer()
                            Text(msg.content)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(12)
                                .background(AppColors.accentCoral)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 5) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 12))
                                    .foregroundColor(AppColors.accentCoral)
                                Text("SoulAI Companion")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(AppColors.accentCoral)
                            }

                            Text(msg.content)
                                .font(.system(size: 14))
                                .foregroundColor(AppColors.textPrimary)
                                .lineSpacing(3)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppColors.surfaceWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(AppColors.borderSubtle, lineWidth: 1)
                        )
                        .shadow(color: AppColors.subtleShadow, radius: 6, y: 2)
                    }
                }

                if viewModel.isAnalyzing {
                    HStack {
                        ProgressView()
                            .tint(AppColors.accentCoral)
                        Text("Refining conversational advice...")
                            .font(.system(size: 12))
                            .foregroundColor(AppColors.textSecondary)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }

    // MARK: - Bottom Input Bar
    private var coachInputBar: some View {
        HStack(spacing: 10) {
            TextField("Ask about messages, openers, or dates...", text: $viewModel.userQuestionInput)
                .font(.system(size: 14))
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(AppColors.surfaceNeutral)
                .clipShape(Capsule())

            Button(action: {
                viewModel.askCoach()
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(viewModel.userQuestionInput.trimmingCharacters(in: .whitespaces).isEmpty ? AppColors.textMuted : AppColors.accentCoral)
            }
            .disabled(viewModel.userQuestionInput.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(AppColors.surfaceWhite)
        .overlay(
            Rectangle().frame(height: 1).foregroundColor(AppColors.borderSubtle), alignment: .top
        )
    }
}

#Preview {
    DatingCoachView()
        .environment(AppState())
}
