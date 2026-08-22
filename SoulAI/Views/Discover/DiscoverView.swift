import SwiftUI

public struct DiscoverView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = DiscoverViewModel()
    @State private var showFilterSheet: Bool = false
    @State private var showSearchSheet: Bool = false

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(spacing: 12) {
                // Top Editorial Header
                headerView
                    .padding(.horizontal, 22)
                    .padding(.top, 12)

                // Main 75% Hero Card Stack Deck
                ZStack {
                    if viewModel.deck.isEmpty {
                        emptyDeckView
                    } else {
                        // Background Card
                        if let next = viewModel.nextProfile {
                            ProfileCardView(profile: next) {
                                appState.selectedMatchForDetail = next
                            }
                            .scaleEffect(0.96)
                            .offset(y: 12)
                            .opacity(0.8)
                            .allowsHitTesting(false)
                        }

                        // Foreground Swiping Card
                        if let top = viewModel.topProfile {
                            ProfileCardView(profile: top) {
                                appState.selectedMatchForDetail = top
                            }
                            .offset(viewModel.cardOffset)
                            .rotationEffect(.degrees(Double(viewModel.cardOffset.width / 22)))
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
                .padding(.horizontal, 18)

                // Bottom Floating Action Buttons
                if !viewModel.deck.isEmpty {
                    actionButtonsBar
                        .padding(.horizontal, 36)
                        .padding(.bottom, 26)
                }
            }

            // Celebration Modal on Match
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
        .sheet(isPresented: $showFilterSheet) {
            filterSheetView
        }
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            // SoulAI Editorial Logo
            HStack(spacing: 4) {
                Text("SoulAI")
                    .font(.system(size: 28, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)

                Circle()
                    .fill(AppColors.accentCoral)
                    .frame(width: 6, height: 6)
            }

            Spacer()

            // Action Icons (Search & Filters)
            HStack(spacing: 10) {
                Button(action: { showSearchSheet.toggle() }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppColors.textPrimary)
                        .frame(width: 38, height: 38)
                        .background(AppColors.surfaceWhite)
                        .clipShape(Circle())
                        .shadow(color: AppColors.subtleShadow, radius: 6, y: 2)
                }

                Button(action: { showFilterSheet.toggle() }) {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppColors.textPrimary)
                        .frame(width: 38, height: 38)
                        .background(AppColors.surfaceWhite)
                        .clipShape(Circle())
                        .shadow(color: AppColors.subtleShadow, radius: 6, y: 2)
                }
            }
        }
    }

    // MARK: - Floating Action Buttons (X Reject, Heart Like, AI Insight)
    private var actionButtonsBar: some View {
        HStack(spacing: 28) {
            // Reject (X)
            Button(action: {
                viewModel.swipeCard(direction: .left)
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(AppColors.textSecondary)
                    .frame(width: 58, height: 58)
                    .background(AppColors.surfaceWhite)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(AppColors.borderSubtle, lineWidth: 1)
                    )
                    .shadow(color: AppColors.subtleShadow, radius: 8, y: 4)
            }

            // AI Insight Sparkle
            Button(action: {
                if let top = viewModel.topProfile {
                    appState.selectedMatchForDetail = top
                }
            }) {
                Image(systemName: "sparkles")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(AppColors.accentCoral)
                    .frame(width: 48, height: 48)
                    .background(AppColors.surfaceWhite)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(AppColors.borderSubtle, lineWidth: 1)
                    )
                    .shadow(color: AppColors.subtleShadow, radius: 6, y: 3)
            }

            // Heart Like (Primary Coral)
            Button(action: {
                viewModel.swipeCard(direction: .right) { matched in
                    appState.likeProfile(matched)
                }
            }) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 66, height: 66)
                    .background(AppColors.accentCoral)
                    .clipShape(Circle())
                    .shadow(color: AppColors.buttonShadow, radius: 14, y: 6)
            }
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
