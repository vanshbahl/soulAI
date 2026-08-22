import SwiftUI

public struct ProfileView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = ProfileViewModel()

    public init() {}

    public var body: some View {
        ZStack {
            BackgroundAtmosphereView()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Profile Header & Large Photo
                    profileHeaderSection
                        .padding(.top, 24)

                    // Minimal Personality Summary
                    personalitySummarySection

                    // Three Clean Interests
                    interestsSection

                    // Relationship Goals
                    intentionsSection

                    // App Settings & Restart Flow
                    settingsSection
                        .padding(.top, 12)
                        .padding(.bottom, 120)
                }
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            viewModel.user = appState.currentUser
        }
    }

    // MARK: - Profile Header Section
    private var profileHeaderSection: some View {
        VStack(spacing: 12) {
            // Large Circular Profile Picture
            Circle()
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#E88B7D"), Color(hex: "#5C3D38")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 110, height: 110)
                .overlay(
                    Text("A")
                        .font(.system(size: 44, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                )
                .overlay(
                    Circle().stroke(AppColors.surfaceWhite, lineWidth: 4)
                )
                .shadow(color: AppColors.subtleShadow, radius: 12, y: 4)

            VStack(spacing: 4) {
                Text("\(viewModel.user.name), \(viewModel.user.age)")
                    .font(.system(size: 26, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)

                Text("\(viewModel.user.occupation) • \(viewModel.user.location)")
                    .font(.system(size: 14))
                    .foregroundColor(AppColors.textSecondary)
            }
        }
    }

    // MARK: - Personality Summary
    private var personalitySummarySection: some View {
        VStack(spacing: 6) {
            Text("ESSENCE")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            Text("\"\(viewModel.user.personalitySummary)\"")
                .font(.system(size: 18, weight: .medium, design: .serif))
                .foregroundColor(AppColors.textPrimary)
                .italic()
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(AppColors.softPeach)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    // MARK: - Three Interests
    private var interestsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("INTERESTS")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            HStack(spacing: 8) {
                ForEach(viewModel.user.interests.prefix(3), id: \.self) { interest in
                    Text(interest)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(AppColors.textPrimary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(AppColors.surfaceWhite)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(AppColors.borderSubtle, lineWidth: 1))
                        .shadow(color: AppColors.subtleShadow, radius: 4, y: 2)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Relationship Goals
    private var intentionsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("DATING INTENTION")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(AppColors.textSecondary)

            HStack(spacing: 12) {
                Image(systemName: viewModel.user.intention.iconName)
                    .foregroundColor(AppColors.accentCoral)
                    .font(.system(size: 18))

                Text(viewModel.user.intention.rawValue)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(AppColors.textPrimary)

                Spacer()
            }
            .padding(16)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(AppColors.borderSubtle, lineWidth: 1))
            .shadow(color: AppColors.subtleShadow, radius: 4, y: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Settings Section
    private var settingsSection: some View {
        VStack(spacing: 12) {
            Button(action: {
                appState.restartOnboarding()
            }) {
                HStack {
                    Image(systemName: "arrow.counterclockwise")
                    Text("Restart Onboarding (Demo)")
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .padding(.vertical, 12)
            }
        }
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
    ProfileView()
        .environment(AppState())
}
