import SwiftUI

/// Semantic color palette and gradients for SoulAI
public enum AppColors {
    // MARK: - Core Accents
    public static let primaryRose = Color(red: 1.0, green: 0.18, blue: 0.39)      // #FF2E63
    public static let vibrantPink = Color(red: 1.0, green: 0.35, blue: 0.58)      // #FF5A94
    public static let electricViolet = Color(red: 0.47, green: 0.16, blue: 0.79)   // #7928CA
    public static let neonPurple = Color(red: 0.61, green: 0.32, blue: 0.88)      // #9B51E0
    public static let auroraTeal = Color(red: 0.0, green: 0.96, blue: 0.83)       // #00F5D4
    public static let sunsetAmber = Color(red: 1.0, green: 0.62, blue: 0.22)      // #FF9E38
    public static let softLilac = Color(red: 0.82, green: 0.75, blue: 0.98)        // #D2C0FA

    // MARK: - Dark Canvas & Surfaces
    public static let backgroundDark = Color(red: 0.04, green: 0.05, blue: 0.08)   // #0B0D14
    public static let cardSurface = Color(red: 0.09, green: 0.11, blue: 0.17)      // #171C2B
    public static let cardSurfaceElevated = Color(red: 0.13, green: 0.16, blue: 0.24) // #21293D
    public static let glassBorder = Color.white.opacity(0.12)
    public static let subtleText = Color(red: 0.65, green: 0.69, blue: 0.78)

    // MARK: - Dynamic Gradients
    public static let soulGradient = LinearGradient(
        colors: [primaryRose, electricViolet],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    public static let auroraGradient = LinearGradient(
        colors: [auroraTeal, electricViolet],
        startPoint: .leading,
        endPoint: .trailing
    )

    public static let warmGlowGradient = LinearGradient(
        colors: [primaryRose, sunsetAmber],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    public static let cardGlassGradient = LinearGradient(
        colors: [
            Color.white.opacity(0.14),
            Color.white.opacity(0.04)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    public static let darkAtmosphereGradient = RadialGradient(
        gradient: Gradient(colors: [
            Color(red: 0.18, green: 0.08, blue: 0.28).opacity(0.7),
            backgroundDark
        ]),
        center: .top,
        startRadius: 40,
        endRadius: 600
    )
}
