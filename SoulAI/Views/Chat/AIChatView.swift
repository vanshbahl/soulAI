import SwiftUI

public struct AIChatView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    let match: MatchProfile
    @State private var viewModel: AIChatViewModel
    @State private var showAiRepliesSheet: Bool = false

    public init(match: MatchProfile) {
        self.match = match
        self._viewModel = State(initialValue: AIChatViewModel(match: match))
    }

    public var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                AppColors.surfaceWhite
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Chat Messages Scroll Area
                    ScrollViewReader { proxy in
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 12) {
                                // Match Header Profile Summary
                                matchHeaderCard
                                    .padding(.vertical, 12)

                                ForEach(viewModel.messages) { message in
                                    chatBubble(message)
                                        .id(message.id)
                                }

                                // Typing Indicator
                                if viewModel.isMatchTyping {
                                    typingIndicatorView
                                        .id("typingIndicator")
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                            .padding(.bottom, 80)
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

                    // Floating "Need help replying?" Pill & Input Bar
                    VStack(spacing: 10) {
                        // Small floating AI help button
                        Button(action: {
                            showAiRepliesSheet.toggle()
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "sparkles")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(AppColors.accentCoral)
                                Text("Need help replying?")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(AppColors.textPrimary)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(AppColors.surfaceWhite)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(AppColors.accentCoral.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: AppColors.subtleShadow, radius: 8, y: 3)
                        }

                        // Chat Input Bar (iMessage Style)
                        chatInputBar
                    }
                    .padding(.bottom, 6)
                    .background(AppColors.surfaceWhite)
                }
            }
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        ZStack(alignment: .bottomTrailing) {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: match.photoGradientStartHex), Color(hex: match.photoGradientEndHex)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Text(String(match.name.prefix(1)))
                                        .font(.system(size: 14, weight: .bold, design: .serif))
                                        .foregroundColor(.white)
                                )

                            Circle()
                                .fill(AppColors.onlineGreen)
                                .frame(width: 9, height: 9)
                                .overlay(Circle().stroke(Color.white, lineWidth: 1.5))
                        }

                        VStack(alignment: .leading, spacing: 1) {
                            Text(match.name)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundColor(AppColors.textPrimary)
                            Text("Active now")
                                .font(.system(size: 11))
                                .foregroundColor(AppColors.textSecondary)
                        }
                    }
                }

                ToolbarItem(placement: .automatic) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(AppColors.textMuted)
                    }
                }
            }
            .sheet(isPresented: $showAiRepliesSheet) {
                aiSuggestedRepliesSheet
            }
        }
    }

    // MARK: - Match Header Summary
    private var matchHeaderCard: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: match.photoGradientStartHex), Color(hex: match.photoGradientEndHex)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 72, height: 72)
                    .overlay(
                        Text(String(match.name.prefix(1)))
                            .font(.system(size: 28, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                    )
            }

            Text("\(match.name), \(match.age)")
                .font(.system(size: 18, weight: .bold, design: .serif))
                .foregroundColor(AppColors.textPrimary)

            Text("\"\(match.emotionalInsight)\"")
                .font(.system(size: 13, weight: .medium, design: .serif))
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .italic()
                .padding(.horizontal, 32)
        }
        .padding(.vertical, 8)
    }

    // MARK: - Message Bubble
    @ViewBuilder
    private func chatBubble(_ msg: ChatMessage) -> some View {
        HStack {
            if msg.sender == .currentUser { Spacer() }

            VStack(alignment: msg.sender == .currentUser ? .trailing : .leading, spacing: 4) {
                Text(msg.content)
                    .font(.system(size: 15))
                    .foregroundColor(msg.sender == .currentUser ? .white : AppColors.textPrimary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 11)
                    .background(
                        msg.sender == .currentUser
                        ? AppColors.accentCoral
                        : AppColors.surfaceNeutral
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

                Text(formatTime(msg.timestamp))
                    .font(.system(size: 10))
                    .foregroundColor(AppColors.textMuted)
                    .padding(.horizontal, 4)
            }

            if msg.sender != .currentUser { Spacer() }
        }
    }

    // MARK: - Typing Indicator
    private var typingIndicatorView: some View {
        HStack {
            HStack(spacing: 4) {
                Circle().fill(AppColors.textMuted).frame(width: 6, height: 6)
                Circle().fill(AppColors.textMuted).frame(width: 6, height: 6)
                Circle().fill(AppColors.textMuted).frame(width: 6, height: 6)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(AppColors.surfaceNeutral)
            .clipShape(Capsule())

            Spacer()
        }
    }

    // MARK: - Chat Input Bar
    private var chatInputBar: some View {
        HStack(spacing: 10) {
            TextField("Message...", text: $viewModel.inputText)
                .font(.system(size: 15))
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(AppColors.surfaceNeutral)
                .clipShape(Capsule())

            Button(action: {
                viewModel.sendMessage()
            }) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(viewModel.inputText.trimmingCharacters(in: .whitespaces).isEmpty ? AppColors.textMuted : AppColors.accentCoral)
            }
            .disabled(viewModel.inputText.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.top, 4)
    }

    // MARK: - AI Suggested Replies Drawer
    private var aiSuggestedRepliesSheet: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "sparkles")
                        .foregroundColor(AppColors.accentCoral)
                    Text("Suggested Responses")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundColor(AppColors.textPrimary)
                }

                Text("Natural, personalized conversation ideas aligned with \(match.name)'s interests:")
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.textSecondary)

                VStack(spacing: 12) {
                    ForEach(viewModel.currentSuggestedReplies.isEmpty ? MockDataProvider.sampleChatMessages[0].aiSuggestedReplies : viewModel.currentSuggestedReplies, id: \.self) { reply in
                        Button(action: {
                            viewModel.selectSuggestedReply(reply)
                            showAiRepliesSheet = false
                        }) {
                            HStack {
                                Text(reply)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(AppColors.textPrimary)
                                    .multilineTextAlignment(.leading)
                                    .lineSpacing(2)

                                Spacer()

                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(AppColors.accentCoral)
                                    .font(.system(size: 20))
                            }
                            .padding(16)
                            .background(AppColors.surfaceWhite)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(AppColors.borderSubtle, lineWidth: 1)
                            )
                            .shadow(color: AppColors.subtleShadow, radius: 6, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                Spacer()
            }
            .padding(24)
            .background(AppColors.backgroundWarm)
        }
        .presentationDetents([.fraction(0.48)])
    }

    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
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
    AIChatView(match: MockDataProvider.sampleMatches[0])
        .environment(AppState())
}
