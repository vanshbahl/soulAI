import SwiftUI

public struct BackgroundAtmosphereView: View {
    public init() {}

    public var body: some View {
        AppColors.backgroundWarm
            .ignoresSafeArea()
    }
}
