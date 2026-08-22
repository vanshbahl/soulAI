import Foundation

public struct DatingCoachPromptCategory: Identifiable, Codable {
    public let id: String
    public let title: String
    public let icon: String
    public let prompts: [String]

    public init(id: String = UUID().uuidString, title: String, icon: String, prompts: [String]) {
        self.id = id
        self.title = title
        self.icon = icon
        self.prompts = prompts
    }
}

public struct DatingCoachAdviceCard: Identifiable, Codable {
    public let id: UUID
    public let title: String
    public let category: String
    public let summary: String
    public let actionableSteps: [String]
    public let icon: String

    public init(
        id: UUID = UUID(),
        title: String,
        category: String,
        summary: String,
        actionableSteps: [String],
        icon: String
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.summary = summary
        self.actionableSteps = actionableSteps
        self.icon = icon
    }
}
