import SwiftUI

public struct ConversationsListView: View {
    @Environment(AppState.self) private var appState

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(alignment: .leading, spacing: 16) {
                // Header
                headerView
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                // Active Matches Story/Bubble Bar
                activeMatchesBar

                // Conversations List
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 8) {
                        ForEach(appState.matches.filter { $0.hasMatched }) { match in
                            conversationRow(match)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 120)
                }
            }
        }
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            Text("Conversations")
                .font(.system(size: 32, weight: .bold, design: .serif))
                .foregroundColor(AppColors.textPrimary)

            Spacer()

            Button(action: {}) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                    .padding(8)
                    .background(AppColors.surfaceWhite)
                    .clipShape(Circle())
                    .shadow(color: AppColors.subtleShadow, radius: 4, y: 2)
            }
        }
    }

    // MARK: - Active Matches Bar
    private var activeMatchesBar: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("NEW CONNECTIONS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)
                .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(appState.matches) { match in
                        Button(action: {
                            appState.selectedMatchForChat = match
                        }) {
                            VStack(spacing: 6) {
                                ZStack(alignment: .bottomTrailing) {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color(hex: match.photoGradientStartHex),
                                                    Color(hex: match.photoGradientEndHex)
                                                ],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 64, height: 64)
                                        .overlay(
                                            Text(String(match.name.prefix(1)))
                                                .font(.system(size: 24, weight: .bold, design: .serif))
                                                .foregroundColor(.white)
                                        )
                                        .overlay(
                                            Circle()
                                                .stroke(AppColors.accentCoral, lineWidth: match.hasMatched ? 2 : 0)
                                        )

                                    if match.lastActiveAgo.contains("now") || match.lastActiveAgo.contains("m") {
                                        Circle()
                                            .fill(AppColors.onlineGreen)
                                            .frame(width: 14, height: 14)
                                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    }
                                }

                                Text(match.name)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(AppColors.textPrimary)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Conversation Row
    private func conversationRow(_ match: MatchProfile) -> some View {
        Button(action: {
            appState.selectedMatchForChat = match
        }) {
            HStack(spacing: 14) {
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(hex: match.photoGradientStartHex),
                                    Color(hex: match.photoGradientEndHex)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 54, height: 54)
                        .overlay(
                            Text(String(match.name.prefix(1)))
                                .font(.system(size: 20, weight: .bold, design: .serif))
                                .foregroundColor(.white)
                        )

                    Circle()
                        .fill(AppColors.onlineGreen)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(match.name)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(AppColors.textPrimary)

                        Spacer()

                        Text("2m ago")
                            .font(.system(size: 12))
                            .foregroundColor(AppColors.textMuted)
                    }

                    Text("Are you free Sunday morning for coffee?")
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(1)
                }
            }
            .padding(14)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(AppColors.borderSubtle, lineWidth: 1)
            )
            .shadow(color: AppColors.subtleShadow, radius: 6, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

private extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
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
    ConversationsListView()
        .environment(AppState())
}
