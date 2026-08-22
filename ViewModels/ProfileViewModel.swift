import SwiftUI
import Observation

public enum BioToneStyle: String, CaseIterable, Identifiable {
    case balanced = "Balanced & Warm"
    case poetic = "Poetic & Deep"
    case witty = "Witty & Playful"
    case direct = "Direct & Minimal"

    public var id: String { rawValue }
}

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
                self.user.aiGeneratedBio = "Designing intuitive worlds by day, searching for cosmic synchronicities and genuine late-night conversations by night. Looking for someone who enjoys vinyl records, honest deep-talks over flat whites, and spontaneous road trips."
            case .poetic:
                self.user.aiGeneratedBio = "Finding poetry in concrete geometries and golden hour shadows. I appreciate quiet co-presence, honest eyes, and conversations that wander past midnight without checking the clock."
            case .witty:
                self.user.aiGeneratedBio = "Fluent in architectural banter, specialty coffee snobbery, and curating overly specific Spotify playlists. Looking for someone to debate the best corner table in San Francisco."
            case .direct:
                self.user.aiGeneratedBio = "Product designer with a passion for spatial audio and quiet cafes. Seeking high emotional clarity, mutual curiosity, and an authentic long-term partner."
            }

            #if os(iOS)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            #endif
        }
    }
}
