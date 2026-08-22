import Foundation

public enum DatingIntention: String, CaseIterable, Identifiable, Codable, Sendable {
    case longTerm = "Soulmate & Long-term"
    case lifePartner = "Deep Connection"
    case casualExploring = "Thoughtful Dating"
    case openToPossibilities = "Open to Possibilities"
    
    public var id: String { rawValue }
    
    public var iconName: String {
        switch self {
        case .longTerm: return "sparkles.rectangle.stack"
        case .lifePartner: return "heart.circle.fill"
        case .casualExploring: return "magnifyingglass"
        case .openToPossibilities: return "wand.and.stars"
        }
    }
}

public struct PersonalityTrait: Identifiable, Hashable, Codable, Sendable {
    public let id: String
    public let name: String
    public let icon: String
    public let category: String

    public init(id: String = UUID().uuidString, name: String, icon: String, category: String = "Core") {
        self.id = id
        self.name = name
        self.icon = icon
        self.category = category
    }
}

public struct PersonalityInsight: Identifiable, Codable, Sendable {
    public let id: UUID
    public let title: String
    public let value: String
    public let icon: String
    public let score: Int // 0 - 100
    public let explanation: String

    public init(
        id: UUID = UUID(),
        title: String,
        value: String,
        icon: String,
        score: Int,
        explanation: String
    ) {
        self.id = id
        self.title = title
        self.value = value
        self.icon = icon
        self.score = score
        self.explanation = explanation
    }
}

public struct UserProfile: Identifiable, Codable, Sendable {
    public var id: UUID
    public var name: String
    public var age: Int
    public var occupation: String
    public var location: String
    public var interests: [String]
    public var traits: [String]
    public var intention: DatingIntention
    public var aiGeneratedBio: String
    public var personalityInsights: [PersonalityInsight]
    public var avatarImageName: String?
    public var soulVibeSummary: String

    public init(
        id: UUID = UUID(),
        name: String = "",
        age: Int = 26,
        occupation: String = "",
        location: String = "San Francisco, CA",
        interests: [String] = [],
        traits: [String] = [],
        intention: DatingIntention = .longTerm,
        aiGeneratedBio: String = "",
        personalityInsights: [PersonalityInsight] = [],
        avatarImageName: String? = nil,
        soulVibeSummary: String = ""
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.occupation = occupation
        self.location = location
        self.interests = interests
        self.traits = traits
        self.intention = intention
        self.aiGeneratedBio = aiGeneratedBio
        self.personalityInsights = personalityInsights
        self.avatarImageName = avatarImageName
        self.soulVibeSummary = soulVibeSummary
    }
}
