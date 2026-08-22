import SwiftUI

public struct AIChatView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    let match: MatchProfile
    @State private var viewModel: AIChatViewModel

    public init(match: MatchProfile) {
        self.match = match
        self._viewModel = State(initialValue: AIChatViewModel(match: match))
    }

    public var body: some View {
        NavigationStack {
            ZStack {
                BackgroundAtmosphereView()

                VStack(spacing: 0) {
                    // Chat Messages Scroll Area
                    ScrollViewReader { proxy in
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 16) {
                                // Match Analysis Top Header in Chat
                                matchIntroHeader
                                    .padding(.bottom, 8)

                                ForEach(viewModel.messages) { message in
                                    messageBubble(message)
                                        .id(message.id)
                                }

                                // Typing Indicator
                                if viewModel.isMatchTyping {
                                    typingIndicatorView
                                        .id("typingIndicator")
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 12)
                            .padding(.bottom, 12)
                        }
                        .onChange(of: viewModel.messages.count) {
                            if let last = viewModel.messages.last {
                                withAnimation {
                                    proxy.scrollTo(last.id, anchor: .bottom)
                                }
                            }
                        }
                        .onChange(of: viewModel.isMatchTyping) {
                            if viewModel.isMatchTyping {
                                withAnimation {
                                    proxy.scrollTo("typingIndicator", anchor: .bottom)
                                }
                            }
                        }
                    }

                    // Smart Suggested Replies Drawer
                    if !viewModel.currentSuggestedReplies.isEmpty {
                        suggestedRepliesBar
                    }

                    // Chat Input Bar
                    chatInputBar
                }
            }
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(AppColors.primaryRose)
                                .frame(width: 32, height: 32)
                            Image(systemName: match.avatarSymbol)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }

                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 4) {
                                Text(match.name)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                CompatibilityBadge(score: match.compatibilityScore, size: .small, showSparkle: false)
                            }
                            Text("Simulated Neural Chat")
                                .font(.system(size: 10))
                                .foregroundColor(AppColors.auroraTeal)
                        }
                    }
                }

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

    // MARK: - Match Intro Header
    private var matchIntroHeader: some View {
        GlassCard(padding: 12) {
            VStack(spacing: 6) {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundColor(AppColors.auroraTeal)
                    Text("SoulAI Active Match Resonance: \(match.compatibilityScore)%")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(AppColors.auroraTeal)
                }

                Text(match.analysis.matchTagline)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Message Bubble
    @ViewBuilder
    private func messageBubble(_ msg: ChatMessage) -> some View {
        VStack(alignment: msg.sender == .currentUser ? .trailing : .leading, spacing: 6) {
            if msg.sender == .soulAIAssistant {
                // AI Assistant Banner
                GlassCard(padding: 12) {
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "wand.and.stars")
                            .font(.system(size: 16))
                            .foregroundColor(AppColors.auroraTeal)
                        Text(msg.content)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.white.opacity(0.95))
                            .lineSpacing(3)
                    }
                }
            } else {
                HStack {
                    if msg.sender == .currentUser { Spacer() }

                    VStack(alignment: msg.sender == .currentUser ? .trailing : .leading, spacing: 4) {
                        Text(msg.content)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(
                                msg.sender == .currentUser
                                ? AnyShapeStyle(AppColors.soulGradient)
                                : AnyShapeStyle(Color.white.opacity(0.12))
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 18,
                                    style: .continuous
                                )
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .stroke(
                                        msg.sender == .currentUser ? Color.white.opacity(0.25) : Color.white.opacity(0.08),
                                        lineWidth: 1
                                    )
                            )
                            .shadow(color: msg.sender == .currentUser ? AppColors.primaryRose.opacity(0.3) : Color.clear, radius: 8)

                        // Message Timestamp
                        Text(formatTime(msg.timestamp))
                            .font(.system(size: 10))
                            .foregroundColor(AppColors.subtleText)
                            .padding(.horizontal, 4)
                    }

                    if msg.sender != .currentUser { Spacer() }
                }

                // AI Insight Tip Ribbon if attached
                if let tip = msg.aiInsightTip {
                    HStack(spacing: 6) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 10))
                            .foregroundColor(AppColors.sunsetAmber)
                        Text(tip)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(AppColors.softLilac)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.06))
                    .clipShape(Capsule())
                }
            }
        }
    }

    // MARK: - Typing Indicator
    private var typingIndicatorView: some View {
        HStack {
            HStack(spacing: 4) {
                Circle().fill(Color.white.opacity(0.7)).frame(width: 6, height: 6)
                Circle().fill(Color.white.opacity(0.7)).frame(width: 6, height: 6)
                Circle().fill(Color.white.opacity(0.7)).frame(width: 6, height: 6)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.white.opacity(0.12))
            .clipShape(Capsule())

            Spacer()
        }
    }

    // MARK: - Suggested Replies Bar
    private var suggestedRepliesBar: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 4) {
                Image(systemName: "sparkles")
                    .font(.system(size: 10))
                    .foregroundColor(AppColors.auroraTeal)
                Text("AI SUGGESTED REPLIES")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(AppColors.auroraTeal)
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.currentSuggestedReplies, id: \.self) { reply in
                        Button(action: {
                            viewModel.selectSuggestedReply(reply)
                        }) {
                            Text(reply)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule().stroke(AppColors.auroraTeal.opacity(0.4), lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 6)
        }
    }

    // MARK: - Chat Input Bar
    private var chatInputBar: some View {
        HStack(spacing: 10) {
            TextField("Type your message...", text: $viewModel.inputText)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.08))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.12), lineWidth: 1)
                )

            Button(action: {
                viewModel.sendMessage()
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(viewModel.inputText.isEmpty ? AnyShapeStyle(Color.white.opacity(0.2)) : AnyShapeStyle(AppColors.soulGradient))
            }
            .disabled(viewModel.inputText.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    AIChatView(match: MockDataProvider.sampleMatches[0])
        .environment(AppState())
}
