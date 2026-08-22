import SwiftUI

public struct MatchCelebrationModal: View {
    let match: MatchProfile
    let onStartChat: () -> Void
    let onDismiss: () -> Void

    @State private var appearAnimation: Bool = false

    public init(match: MatchProfile, onStartChat: @escaping () -> Void, onDismiss: @escaping () -> Void) {
        self.match = match
        self.onStartChat = onStartChat
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack {
            // Warm translucent overlay
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            // Central Emotional Match Card
            VStack(spacing: 24) {
                // Top Title
                Text("It's a Match ❤️")
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                    .padding(.top, 10)

                // Two Overlapping Circular Profile Photos
                HStack(spacing: -24) {
                    // User Circular Avatar
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "#E88B7D"), Color(hex: "#5C3D38")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 104, height: 104)
                        .overlay(
                            Text("A")
                                .font(.system(size: 38, weight: .bold, design: .serif))
                                .foregroundColor(.white)
                        )
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(color: AppColors.subtleShadow, radius: 10, y: 4)

                    // Match Circular Avatar
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: match.photoGradientStartHex), Color(hex: match.photoGradientEndHex)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 104, height: 104)
                        .overlay(
                            Text(String(match.name.prefix(1)))
                                .font(.system(size: 38, weight: .bold, design: .serif))
                                .foregroundColor(.white)
                        )
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(color: AppColors.subtleShadow, radius: 10, y: 4)
                }
                .scaleEffect(appearAnimation ? 1.0 : 0.8)
                .padding(.vertical, 8)

                // Compatibility Pill
                Text("\(match.compatibilityScore)% compatibility")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(AppColors.accentCoral)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(AppColors.softPeach)
                    .clipShape(Capsule())

                // One Short AI Emotional Insight
                Text("\"\(match.emotionalInsight)\"")
                    .font(.system(size: 16, weight: .medium, design: .serif))
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .italic()
                    .lineSpacing(4)
                    .padding(.horizontal, 16)

                // Start Conversation Button
                SoulButton(
                    title: "Start conversation",
                    iconName: "bubble.left.fill",
                    style: .primaryGradient
                ) {
                    onStartChat()
                }
                .padding(.top, 8)

                // Dismiss
                Button(action: onDismiss) {
                    Text("Keep Browsing")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                }
                .padding(.bottom, 6)
            }
            .padding(28)
            .background(AppColors.surfaceWhite)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .stroke(AppColors.borderSubtle, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.12), radius: 24, x: 0, y: 12)
            .padding(.horizontal, 24)
            .scaleEffect(appearAnimation ? 1.0 : 0.9)
            .opacity(appearAnimation ? 1.0 : 0.0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.72)) {
                appearAnimation = true
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
    MatchCelebrationModal(
        match: MockDataProvider.sampleMatches[0],
        onStartChat: {},
        onDismiss: {}
    )
}
