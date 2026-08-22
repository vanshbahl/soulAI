import SwiftUI

public struct MatchListView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = MatchViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            VStack(alignment: .leading, spacing: 16) {
                // Header
                headerView
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                // Matches Grid
                let matches = appState.matches

                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 14) {
                        ForEach(matches) { match in
                            matchGridCard(match)
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
        VStack(alignment: .leading, spacing: 4) {
            Text("Matches")
                .font(.system(size: 32, weight: .bold, design: .serif))
                .foregroundColor(AppColors.textPrimary)

            Text("Curated connections with high emotional resonance")
                .font(.system(size: 14))
                .foregroundColor(AppColors.textSecondary)
        }
    }

    // MARK: - Grid Card
    private func matchGridCard(_ match: MatchProfile) -> some View {
        Button(action: {
            appState.selectedMatchForDetail = match
        }) {
            VStack(alignment: .leading, spacing: 10) {
                // Photo Canvas
                ZStack(alignment: .topTrailing) {
                    LinearGradient(
                        colors: [Color(hex: match.photoGradientStartHex), Color(hex: match.photoGradientEndHex)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        Text(String(match.name.prefix(1)))
                            .font(.system(size: 40, weight: .bold, design: .serif))
                            .foregroundColor(.white)
                    )

                    // Match % Pill
                    Text("\(match.compatibilityScore)%")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.95))
                        .clipShape(Capsule())
                        .padding(10)
                }

                // Info
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(match.name), \(match.age)")
                        .font(.system(size: 16, weight: .bold, design: .serif))
                        .foregroundColor(AppColors.textPrimary)

                    Text(match.occupation)
                        .font(.system(size: 13))
                        .foregroundColor(AppColors.textSecondary)
                        .lineLimit(1)
                }
                .padding(.horizontal, 4)
                .padding(.bottom, 6)
            }
            .padding(8)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(AppColors.borderSubtle, lineWidth: 1)
            )
            .shadow(color: AppColors.subtleShadow, radius: 8, y: 3)
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
    MatchListView()
        .environment(AppState())
}
