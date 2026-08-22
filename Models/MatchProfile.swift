import Foundation

public struct MatchProfile: Identifiable, Codable, Sendable {
    public let id: UUID
    public let name: String
    public let age: Int
    public let occupation: String
    public let location: String
    public let distanceMiles: Int
    public let aiGeneratedBio: String
    public let vibeKeywords: [String]
    public let interests: [String]
    public let traits: [String]
    public let compatibilityScore: Int
    public let matchReasons: [String]
    public let gradientThemeName: String
    public let avatarSymbol: String
    public let analysis: MatchAnalysis
    public var hasMatched: Bool
    public let lastActiveAgo: String

    public init(
        id: UUID = UUID(),
        name: String,
        age: Int,
        occupation: String,
        location: String,
        distanceMiles: Int,
        aiGeneratedBio: String,
        vibeKeywords: [String],
        interests: [String],
        traits: [String],
        compatibilityScore: Int,
        matchReasons: [String],
        gradientThemeName: String = "rose",
        avatarSymbol: String = "person.crop.circle.fill",
        analysis: MatchAnalysis,
        hasMatched: Bool = false,
        lastActiveAgo: String = "Active now"
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.occupation = occupation
        self.location = location
        self.distanceMiles = distanceMiles
        self.aiGeneratedBio = aiGeneratedBio
        self.vibeKeywords = vibeKeywords
        self.interests = interests
        self.traits = traits
        self.compatibilityScore = compatibilityScore
        self.matchReasons = matchReasons
        self.gradientThemeName = gradientThemeName
        self.avatarSymbol = avatarSymbol
        self.analysis = analysis
        self.hasMatched = hasMatched
        self.lastActiveAgo = lastActiveAgo
    }
}
