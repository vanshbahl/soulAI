import SwiftUI
import Observation

public enum BioToneStyle: String, CaseIterable, Identifiable {
    case balanced = "Balanced & Warm"
    case poetic = "Poetic & Deep"
    case witty = "Witty & Playful"
    case direct = "Direct & Minimal"

    public var id: String { rawValue }
}

@MainActor
@Observable
public final class ProfileViewModel {
    public var user: UserProfile
    public var selectedBioTone: BioToneStyle = .balanced
    public var isRegeneratingBio: Bool = false
    public var showEditInterestsModal: Bool = false

    public init(user: UserProfile = MockDataProvider.sampleUser) {
        self.user = user
    }

    public func regenerateBio(tone: BioToneStyle) {
        isRegeneratingBio = true
        selectedBioTone = tone

        #if os(iOS)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        #endif

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard let self = self else { return }
            self.isRegeneratingBio = false

            switch tone {
            case .balanced:
                self.user.quote = "Designing intuitive worlds by day, searching for cosmic synchronicities and genuine late-night conversations."
            case .poetic:
                self.user.quote = "Finding poetry in concrete geometries and golden hour shadows. Quiet co-presence and honest eyes."
            case .witty:
                self.user.quote = "Fluent in architectural banter, specialty coffee, and finding the best corner table in SF."
            case .direct:
                self.user.quote = "Product designer passionate about spatial audio, quiet cafes, and authentic long-term partnership."
            }

            #if os(iOS)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            #endif
        }
    }
}
