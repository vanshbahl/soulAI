import Foundation

public struct MatchProfile: Identifiable, Codable, Sendable {
    public let id: UUID
    public let name: String
    public let age: Int
    public let occupation: String
    public let location: String
    public let distanceMiles: Int
    public let quote: String
    public let personalitySummary: String
    public let tags: [String]
    public let compatibilityScore: Int
    public let emotionalInsight: String
    public let avatarSymbol: String
    public let photoGradientStartHex: String
    public let photoGradientEndHex: String
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
        quote: String,
        personalitySummary: String,
        tags: [String],
        compatibilityScore: Int,
        emotionalInsight: String,
        avatarSymbol: String = "person.fill",
        photoGradientStartHex: String = "#E88B7D",
        photoGradientEndHex: String = "#4A3331",
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
        self.quote = quote
        self.personalitySummary = personalitySummary
        self.tags = tags
        self.compatibilityScore = compatibilityScore
        self.emotionalInsight = emotionalInsight
        self.avatarSymbol = avatarSymbol
        self.photoGradientStartHex = photoGradientStartHex
        self.photoGradientEndHex = photoGradientEndHex
        self.analysis = analysis
        self.hasMatched = hasMatched
        self.lastActiveAgo = lastActiveAgo
    }
}
