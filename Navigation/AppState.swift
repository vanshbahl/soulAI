import SwiftUI
import Observation

public enum AppTab: String, CaseIterable, Identifiable {
    case discover = "Discover"
    case matches = "Matches"
    case coach = "AI Coach"
    case profile = "Profile"

    public var id: String { rawValue }

    public var iconName: String {
        switch self {
        case .discover: return "flame.fill"
        case .matches: return "heart.fill"
        case .coach: return "wand.and.stars"
        case .profile: return "person.crop.circle"
        }
    }
}

@MainActor
@Observable
public final class AppState {
    public var isOnboarded: Bool = true // Set default to true for preview, togglable in settings
    public var selectedTab: AppTab = .discover
    public var currentUser: UserProfile = MockDataProvider.sampleUser
    public var matches: [MatchProfile] = MockDataProvider.sampleMatches
    
    // Active navigation sheets & detail states
    public var selectedMatchForDetail: MatchProfile? = nil
    public var selectedMatchForChat: MatchProfile? = nil
    public var celebrationMatch: MatchProfile? = nil

    public init(isOnboarded: Bool = true) {
        self.isOnboarded = isOnboarded
    }

    public func restartOnboarding() {
        self.isOnboarded = false
        self.selectedTab = .discover
    }

    public func completeOnboarding(profile: UserProfile) {
        self.currentUser = profile
        self.isOnboarded = true
        self.selectedTab = .discover
    }

    public func likeProfile(_ profile: MatchProfile) {
        if let index = matches.firstIndex(where: { $0.id == profile.id }) {
            matches[index].hasMatched = true
            celebrationMatch = matches[index]
        }
    }

    public func passProfile(_ profile: MatchProfile) {
        // Can archive or dismiss
    }
}
