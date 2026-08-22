import SwiftUI

public struct DiscoverView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = DiscoverViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(spacing: 12) {
                // Top Discover Header
                headerView
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                // Card Stack Deck
                ZStack {
                    if viewModel.deck.isEmpty {
                        emptyDeckView
                    } else {
                        // Background Card (Next in queue)
                        if let next = viewModel.nextProfile {
                            ProfileCardView(profile: next) {
                                appState.selectedMatchForDetail = next
                            }
                            .scaleEffect(0.94)
                            .offset(y: 16)
                            .opacity(0.65)
                            .allowsHitTesting(false)
                        }

                        // Foreground Swiping Card
                        if let top = viewModel.topProfile {
                            ProfileCardView(profile: top) {
                                appState.selectedMatchForDetail = top
                            }
                            .offset(viewModel.cardOffset)
                            .rotationEffect(.degrees(Double(viewModel.cardOffset.width / 18)))
                            .overlay(swipeOverlay)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        viewModel.updateOffset(value.translation)
                                    }
                                    .onEnded { _ in
                                        if let direction = viewModel.endOffset() {
                                            viewModel.swipeCard(direction: direction) { matched in
                                                appState.likeProfile(matched)
                                            }
                                        }
                                    }
                            )
                            .animation(.spring(response: 0.35, dampingFraction: 0.75), value: viewModel.cardOffset)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)

                // Bottom Action Buttons
                if !viewModel.deck.isEmpty {
                    actionButtonsBar
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                }
            }

            // Celebration Modal when a match occurs
            if viewModel.showMatchModal, let matched = viewModel.matchedProfile {
                MatchCelebrationModal(
                    match: matched,
                    onStartChat: {
                        viewModel.showMatchModal = false
                        appState.selectedMatchForChat = matched
                    },
                    onDismiss: {
                        viewModel.showMatchModal = false
                    }
                )
                .transition(.opacity)
                .zIndex(10)
            }
        }
        .sheet(item: Bindable(appState).selectedMatchForDetail) { match in
            MatchDetailView(match: match)
        }
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .foregroundColor(AppColors.primaryRose)
                    .font(.system(size: 20))
                Text("SoulAI")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundStyle(AppColors.soulGradient)
            }

            Spacer()

            HStack(spacing: 6) {
                Circle()
                    .fill(AppColors.auroraTeal)
                    .frame(width: 8, height: 8)
                Text("Neural Sync Active")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(AppColors.auroraTeal)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.white.opacity(0.08))
            .clipShape(Capsule())
        }
    }

    // MARK: - Swipe Feedback Overlays
    @ViewBuilder
    private var swipeOverlay: some View {
        ZStack {
            if viewModel.cardOffset.width > 30 {
                // LIKE Overlay
                VStack {
                    HStack {
                        Text("SOUL LIKE")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundColor(AppColors.auroraTeal)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.auroraTeal, lineWidth: 3)
                            )
                            .rotationEffect(.degrees(-15))
                            .opacity(Double(min(viewModel.cardOffset.width / 100, 1.0)))
                            .padding(24)
                        Spacer()
                    }
                    Spacer()
                }
            } else if viewModel.cardOffset.width < -30 {
                // PASS Overlay
                VStack {
                    HStack {
                        Spacer()
                        Text("PASS")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundColor(AppColors.primaryRose)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppColors.primaryRose, lineWidth: 3)
                            )
                            .rotationEffect(.degrees(15))
                            .opacity(Double(min(-viewModel.cardOffset.width / 100, 1.0)))
                            .padding(24)
                    }
                    Spacer()
                }
            }
        }
    }

    // MARK: - Action Buttons
    private var actionButtonsBar: some View {
        HStack(spacing: 18) {
            // Rewind
            actionButton(icon: "arrow.uturn.backward", color: AppColors.sunsetAmber, size: 48) {
                viewModel.undoSwipe()
            }

            // Pass
            actionButton(icon: "xmark", color: AppColors.primaryRose, size: 60) {
                viewModel.swipeCard(direction: .left)
            }

            // Super Like (Deep Soul Sync)
            actionButton(icon: "star.fill", color: AppColors.auroraTeal, size: 48) {
                viewModel.swipeCard(direction: .up) { matched in
                    appState.likeProfile(matched)
                }
            }

            // Like
            actionButton(icon: "heart.fill", color: AppColors.primaryRose, size: 60, isPrimary: true) {
                viewModel.swipeCard(direction: .right) { matched in
                    appState.likeProfile(matched)
                }
            }
        }
    }

    private func actionButton(icon: String, color: Color, size: CGFloat, isPrimary: Bool = false, action: @escaping () -> Void) -> some View {
        Button(action: {
            #if os(iOS)
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            #endif
            action()
        }) {
            ZStack {
                Circle()
                    .fill(isPrimary ? AnyShapeStyle(AppColors.soulGradient) : AnyShapeStyle(Color.white.opacity(0.1)))
                    .frame(width: size, height: size)
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.15), lineWidth: 1)
                    )
                    .shadow(color: isPrimary ? AppColors.primaryRose.opacity(0.4) : Color.black.opacity(0.2), radius: 10, y: 5)

                Image(systemName: icon)
                    .font(.system(size: size * 0.42, weight: .bold))
                    .foregroundColor(isPrimary ? .white : color)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Empty Deck View
    private var emptyDeckView: some View {
        GlassCard {
            VStack(spacing: 20) {
                Image(systemName: "sparkles.rectangle.stack.fill")
                    .font(.system(size: 54))
                    .foregroundStyle(AppColors.soulGradient)
                    .symbolEffect(.pulse, options: .repeating)

                VStack(spacing: 8) {
                    Text("All Profiles Explored!")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Text("Our AI is continuously synthesizing new profiles aligned with your personality vectors.")
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.subtleText)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }

                SoulButton(
                    title: "Refresh Discover Deck",
                    iconName: "arrow.clockwise",
                    style: .primaryGradient,
                    fullWidth: false
                ) {
                    viewModel.reloadDeck()
                }
                .padding(.top, 8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 32)
        }
    }
}
