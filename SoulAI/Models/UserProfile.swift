import Foundation

public enum DatingIntention: String, CaseIterable, Identifiable, Codable, Sendable {
    case longTerm = "Soulmate & Long-term"
    case lifePartner = "Deep Connection"
    case casualExploring = "Thoughtful Dating"
    case openToPossibilities = "Open to Possibilities"
    
    public var id: String { rawValue }
    
    public var iconName: String {
        switch self {
        case .longTerm: return "heart.fill"
        case .lifePartner: return "sparkles"
        case .casualExploring: return "magnifyingglass"
        case .openToPossibilities: return "wand.and.stars"
        }
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
    public var personalitySummary: String
    public var interests: [String]
    public var traits: [String]
    public var intention: DatingIntention
    public var quote: String
    public var personalityInsights: [PersonalityInsight]

    public init(
        id: UUID = UUID(),
        name: String = "Alex",
        age: Int = 26,
        occupation: String = "Product Designer",
        location: String = "San Francisco",
        personalitySummary: String = "Creative explorer",
        interests: [String] = ["Architecture", "Coffee", "Vinyl"],
        traits: [String] = ["Empathetic", "Curious", "Reflective"],
        intention: DatingIntention = .longTerm,
        quote: String = "Designing spaces with intention and looking for genuine conversations.",
        personalityInsights: [PersonalityInsight] = []
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.occupation = occupation
        self.location = location
        self.personalitySummary = personalitySummary
        self.interests = interests
        self.traits = traits
        self.intention = intention
        self.quote = quote
        self.personalityInsights = personalityInsights
    }
}
