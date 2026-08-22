import SwiftUI

public struct MatchCelebrationModal: View {
    let match: MatchProfile
    let onStartChat: () -> Void
    let onDismiss: () -> Void

    @State private var appearAnimation: Bool = false
    @State private var beamPulse: Bool = false

    public init(match: MatchProfile, onStartChat: @escaping () -> Void, onDismiss: @escaping () -> Void) {
        self.match = match
        self.onStartChat = onStartChat
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            VStack(spacing: 24) {
                Spacer()

                // Top Sparkle Header
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .foregroundColor(AppColors.auroraTeal)
                            .font(.system(size: 24))
                            .symbolEffect(.bounce, options: .repeating)
                        Text("It's a Soul Match!")
                            .font(.system(size: 32, weight: .black, design: .rounded))
                            .foregroundStyle(AppColors.soulGradient)
                    }

                    Text("You and \(match.name) share exceptional resonance")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppColors.softLilac)
                }
                .scaleEffect(appearAnimation ? 1.0 : 0.8)
                .opacity(appearAnimation ? 1.0 : 0.0)

                // Connected Avatars Graphic
                HStack(spacing: -16) {
                    // User Avatar
                    ZStack {
                        Circle()
                            .fill(AppColors.primaryRose)
                            .frame(width: 90, height: 90)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 38))
                                    .foregroundColor(.white)
                            )
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 3)
                            )
                    }
                    .shadow(color: AppColors.primaryRose.opacity(0.6), radius: 16)

                    // Connecting Compatibility Badge in the center
                    ZStack {
                        Circle()
                            .fill(AppColors.cardSurfaceElevated)
                            .frame(width: 54, height: 54)
                            .overlay(
                                Circle().stroke(AppColors.auroraTeal, lineWidth: 2)
                            )

                        Text("\(match.compatibilityScore)%")
                            .font(.system(size: 14, weight: .black, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .zIndex(2)

                    // Match Avatar
                    ZStack {
                        Circle()
                            .fill(AppColors.electricViolet)
                            .frame(width: 90, height: 90)
                            .overlay(
                                Image(systemName: match.avatarSymbol)
                                    .font(.system(size: 38))
                                    .foregroundColor(.white)
                            )
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 3)
                            )
                    }
                    .shadow(color: AppColors.electricViolet.opacity(0.6), radius: 16)
                }
                .scaleEffect(appearAnimation ? 1.0 : 0.6)
                .padding(.vertical, 10)

                // Match Analysis Snapshot Card
                GlassCard {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "wand.and.stars")
                                .foregroundColor(AppColors.auroraTeal)
                            Text("SOUL SYNERGY")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundColor(AppColors.auroraTeal)
                        }

                        Text(match.analysis.matchTagline)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)

                        if let firstStarter = match.analysis.conversationStarters.first {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Suggested Opener:")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(AppColors.softLilac)
                                Text("\"\(firstStarter)\"")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(Color.white.opacity(0.85))
                                    .italic()
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .opacity(appearAnimation ? 1.0 : 0.0)

                Spacer()

                // Action Buttons
                VStack(spacing: 12) {
                    SoulButton(
                        title: "Start AI-Assisted Chat",
                        iconName: "bubble.left.and.bubble.right.fill",
                        style: .primaryGradient
                    ) {
                        onStartChat()
                    }

                    Button(action: onDismiss) {
                        Text("Keep Swiping")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(AppColors.softLilac)
                            .padding(.vertical, 12)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 36)
                .opacity(appearAnimation ? 1.0 : 0.0)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                appearAnimation = true
            }
        }
    }
}
