import SwiftUI

/// Premium Editorial Light-Mode Color Palette for SoulAI
public enum AppColors {
    // MARK: - Core Accent
    /// Deep Coral / Rose - The ONE distinctive accent
    public static let accentCoral = Color(red: 1.0, green: 0.35, blue: 0.48)       // #FF5A7A
    public static let accentCoralDark = Color(red: 0.92, green: 0.25, blue: 0.38)   // #EB4061
    public static let softPeach = Color(red: 1.0, green: 0.94, blue: 0.93)         // #FFF0ED
    public static let warmRoseTint = Color(red: 0.99, green: 0.91, blue: 0.92)      // #FDEDEF

    // MARK: - Canvas & Backgrounds (Light Mode Only)
    public static let backgroundWarm = Color(red: 0.98, green: 0.97, blue: 0.96)    // #FAF8F5
    public static let surfaceWhite = Color.white                                   // #FFFFFF
    public static let surfaceNeutral = Color(red: 0.95, green: 0.94, blue: 0.92)   // #F3EFEA
    public static let surfaceElevated = Color(red: 0.98, green: 0.97, blue: 0.95)  // #FAF7F2

    // MARK: - Typography & Text
    public static let textPrimary = Color(red: 0.11, green: 0.10, blue: 0.09)      // #1C1917 (Charcoal)
    public static let textSecondary = Color(red: 0.47, green: 0.44, blue: 0.42)    // #78716C (Warm Grey)
    public static let textMuted = Color(red: 0.66, green: 0.64, blue: 0.62)        // #A8A29E (Muted)
    public static let textOnAccent = Color.white

    // MARK: - Subtle Borders & Dividers
    public static let borderSubtle = Color.black.opacity(0.06)
    public static let borderLight = Color.black.opacity(0.03)

    // MARK: - Status
    public static let onlineGreen = Color(red: 0.13, green: 0.77, blue: 0.37)      // #22C55E

    // MARK: - Shadows
    public static let subtleShadow = Color.black.opacity(0.05)
    public static let pillShadow = Color.black.opacity(0.08)
    public static let buttonShadow = accentCoral.opacity(0.28)

    // MARK: - Gradients (Used solely for imagery vignettes and subtle transitions)
    public static let photoOverlayGradient = LinearGradient(
        colors: [
            Color.clear,
            Color.black.opacity(0.2),
            Color.black.opacity(0.85)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    public static let coralGradient = LinearGradient(
        colors: [accentCoral, accentCoralDark],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    public static let softHeroGradient = LinearGradient(
        colors: [
            Color(red: 0.98, green: 0.92, blue: 0.90),
            Color(red: 0.95, green: 0.91, blue: 0.89)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
