import SwiftUI

public struct MatchListView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = MatchViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(spacing: 16) {
                // Header
                headerView
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                // Search Bar
                searchBar
                    .padding(.horizontal, 20)

                // Filter Chips
                filterChipsBar
                    .padding(.horizontal, 20)

                // Matches List
                let filtered = viewModel.filteredMatches(from: appState.matches)

                if filtered.isEmpty {
                    emptyMatchesView
                        .padding(.horizontal, 20)
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 14) {
                            ForEach(filtered) { match in
                                matchRowItem(match)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
            }
        }
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Soul Matches")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("\(appState.matches.count) high-resonance connections")
                    .font(.system(size: 13))
                    .foregroundColor(AppColors.subtleText)
            }
            Spacer()
        }
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.subtleText)
                .font(.system(size: 15))

            TextField("Search matches, interests, or vibe...", text: $viewModel.searchQuery)
                .foregroundColor(.white)
                .font(.system(size: 14))

            if !viewModel.searchQuery.isEmpty {
                Button(action: { viewModel.searchQuery = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(AppColors.subtleText)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.08))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }

    // MARK: - Filter Chips
    private var filterChipsBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(MatchFilter.allCases) { filter in
                    TagPillView(
                        title: filter.rawValue,
                        isSelected: viewModel.filter == filter,
                        isSelectable: true
                    ) {
                        viewModel.filter = filter
                    }
                }
            }
        }
    }

    // MARK: - Match Row Item
    private func matchRowItem(_ match: MatchProfile) -> some View {
        GlassCard(padding: 14) {
            HStack(spacing: 14) {
                // Avatar
                ZStack {
                    Circle()
                        .fill(AppColors.primaryRose.opacity(0.85))
                        .frame(width: 58, height: 58)
                    Image(systemName: match.avatarSymbol)
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }

                // Info
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(match.name)
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("\(match.age)")
                            .font(.system(size: 15))
                            .foregroundColor(AppColors.softLilac)

                        Spacer()

                        CompatibilityBadge(score: match.compatibilityScore, size: .small)
                    }

                    Text(match.occupation)
                        .font(.system(size: 13))
                        .foregroundColor(Color.white.opacity(0.8))
                        .lineLimit(1)

                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 6, height: 6)
                        Text(match.lastActiveAgo)
                            .font(.system(size: 11))
                            .foregroundColor(AppColors.subtleText)
                    }
                }

                // Quick Action Chat Button
                Button(action: {
                    appState.selectedMatchForChat = match
                }) {
                    Image(systemName: "bubble.left.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(AppColors.soulGradient)
                        .clipShape(Circle())
                        .shadow(color: AppColors.primaryRose.opacity(0.4), radius: 6)
                }
            }
        }
        .onTapGesture {
            appState.selectedMatchForDetail = match
        }
    }

    // MARK: - Empty State
    private var emptyMatchesView: some View {
        GlassCard {
            VStack(spacing: 16) {
                Image(systemName: "magnifyingglass.circle")
                    .font(.system(size: 44))
                    .foregroundColor(AppColors.softLilac)
                Text("No matches found")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                Text("Try adjusting your search terms or filter.")
                    .font(.system(size: 13))
                    .foregroundColor(AppColors.subtleText)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
        }
    }
}

#Preview {
    MatchListView()
        .environment(AppState())
}
