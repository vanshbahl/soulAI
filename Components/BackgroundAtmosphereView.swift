import SwiftUI

public struct BackgroundAtmosphereView: View {
    @State private var animateOrb: Bool = false

    public init() {}

    public var body: some View {
        ZStack {
            AppColors.backgroundDark
                .ignoresSafeArea()

            // Ambient floating gradient orbs
            Circle()
                .fill(AppColors.primaryRose.opacity(0.18))
                .frame(width: 320, height: 320)
                .blur(radius: 80)
                .offset(x: animateOrb ? -100 : -60, y: animateOrb ? -220 : -280)

            Circle()
                .fill(AppColors.electricViolet.opacity(0.22))
                .frame(width: 380, height: 380)
                .blur(radius: 90)
                .offset(x: animateOrb ? 120 : 80, y: animateOrb ? -80 : -140)

            Circle()
                .fill(AppColors.auroraTeal.opacity(0.12))
                .frame(width: 300, height: 300)
                .blur(radius: 80)
                .offset(x: animateOrb ? -80 : -40, y: animateOrb ? 280 : 340)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 8.0).repeatForever(autoreverses: true)) {
                animateOrb = true
            }
        }
    }
}
