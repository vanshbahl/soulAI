import Foundation

public struct CompatibilityDimension: Identifiable, Codable, Sendable {
    public let id: UUID
    public let title: String
    public let score: Int // 0 - 100
    public let detail: String

    public init(id: UUID = UUID(), title: String, score: Int, detail: String) {
        self.id = id
        self.title = title
        self.score = score
        self.detail = detail
    }
}

public struct MatchAnalysis: Identifiable, Codable, Sendable {
    public let id: UUID
    public let overallScore: Int
    public let matchTagline: String
    public let strengths: [String]
    public let possibleChallenges: [String]
    public let dimensions: [CompatibilityDimension]
    public let aiAdviceSummary: String
    public let conversationStarters: [String]

    public init(
        id: UUID = UUID(),
        overallScore: Int,
        matchTagline: String,
        strengths: [String],
        possibleChallenges: [String],
        dimensions: [CompatibilityDimension],
        aiAdviceSummary: String,
        conversationStarters: [String]
    ) {
        self.id = id
        self.overallScore = overallScore
        self.matchTagline = matchTagline
        self.strengths = strengths
        self.possibleChallenges = possibleChallenges
        self.dimensions = dimensions
        self.aiAdviceSummary = aiAdviceSummary
        self.conversationStarters = conversationStarters
    }
}
