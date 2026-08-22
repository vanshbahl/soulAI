import SwiftUI

public struct DiscoverView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = DiscoverViewModel()
    @State private var selectedMode: DiscoverMode = .forYou
    @State private var showFilterSheet: Bool = false
    @State private var showAiInsightSheet: Bool = false
    @State private var selectedInsightProfile: MatchProfile? = nil

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(spacing: 8) {
                // Top Header (Logo, Mode Selector, Filter Button)
                DiscoverHeader(selectedMode: $selectedMode) {
                    showFilterSheet.toggle()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)

                // Main 85% Hero Portrait Card Deck
                ZStack {
                    if viewModel.deck.isEmpty {
                        emptyDeckView
                    } else {
                        // Background Next Card
                        if let next = viewModel.nextProfile {
                            PremiumProfileCard(
                                profile: next,
                                onAiInsightTap: {
                                    selectedInsightProfile = next
                                    showAiInsightSheet = true
                                },
                                onCardTap: {
                                    appState.selectedMatchForDetail = next
                                }
                            )
                            .scaleEffect(0.95)
                            .offset(y: 12)
                            .opacity(0.85)
                            .allowsHitTesting(false)
                        }

                        // Foreground Swiping Hero Card
                        if let top = viewModel.topProfile {
                            PremiumProfileCard(
                                profile: top,
                                onAiInsightTap: {
                                    selectedInsightProfile = top
                                    showAiInsightSheet = true
                                },
                                onCardTap: {
                                    appState.selectedMatchForDetail = top
                                }
                            )
                            .offset(viewModel.cardOffset)
                            .rotationEffect(.degrees(Double(viewModel.cardOffset.width / 24)))
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
                            .animation(.spring(response: 0.32, dampingFraction: 0.75), value: viewModel.cardOffset)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 14)

                // Bottom Floating Action Bar (Pass, AI Insight, Like)
                if !viewModel.deck.isEmpty {
                    FloatingActionBar(
                        onPass: {
                            viewModel.swipeCard(direction: .left)
                        },
                        onAiInsight: {
                            if let top = viewModel.topProfile {
                                selectedInsightProfile = top
                                showAiInsightSheet = true
                            }
                        },
                        onLike: {
                            viewModel.swipeCard(direction: .right) { matched in
                                appState.likeProfile(matched)
                            }
                        }
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 80) // Space above floating tab bar
                }
            }

            // Match Celebration Modal on Match
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
        .sheet(isPresented: $showAiInsightSheet) {
            if let profile = selectedInsightProfile ?? viewModel.topProfile {
                AIInsightSheet(match: profile)
            }
        }
        .sheet(isPresented: $showFilterSheet) {
            filterSheetView
        }
    }

    // MARK: - Empty Deck View
    private var emptyDeckView: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.circle")
                .font(.system(size: 52))
                .foregroundColor(AppColors.accentCoral)

            Text("You've seen everyone today")
                .font(.system(size: 22, weight: .bold, design: .serif))
                .foregroundColor(AppColors.textPrimary)

            Text("Check back tomorrow for new curated connections.")
                .font(.system(size: 14))
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Button(action: { viewModel.reloadDeck() }) {
                Text("Refresh Deck")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(AppColors.accentCoral)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(AppColors.softPeach)
                    .clipShape(Capsule())
            }
            .padding(.top, 8)
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
        .background(AppColors.surfaceWhite)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(AppColors.borderSubtle, lineWidth: 1))
        .shadow(color: AppColors.subtleShadow, radius: 8, y: 3)
    }

    // MARK: - Filter Sheet
    private var filterSheetView: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Preferences")
                    .font(.system(size: 24, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)

                VStack(alignment: .leading, spacing: 10) {
                    Text("DISTANCE")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)
                    Text("Within 25 miles • San Francisco Bay Area")
                        .font(.system(size: 15))
                        .foregroundColor(AppColors.textPrimary)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("DATING INTENTION")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)
                    Text("Soulmate & Long-term")
                        .font(.system(size: 15))
                        .foregroundColor(AppColors.textPrimary)
                }

                Spacer()

                SoulButton(title: "Apply Preferences") {
                    showFilterSheet = false
                }
            }
            .padding(24)
            .background(AppColors.backgroundWarm)
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    DiscoverView()
        .environment(AppState())
}
