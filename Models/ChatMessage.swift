import Foundation

public enum MessageSender: String, Codable, Sendable {
    case currentUser
    case matchUser
    case soulAIAssistant
    case coach
}

public struct ChatMessage: Identifiable, Codable, Sendable {
    public let id: UUID
    public let sender: MessageSender
    public let content: String
    public let timestamp: Date
    public let aiSuggestedReplies: [String]
    public let aiInsightTip: String?
    public let isTypingIndicator: Bool

    public init(
        id: UUID = UUID(),
        sender: MessageSender,
        content: String,
        timestamp: Date = Date(),
        aiSuggestedReplies: [String] = [],
        aiInsightTip: String? = nil,
        isTypingIndicator: Bool = false
    ) {
        self.id = id
        self.sender = sender
        self.content = content
        self.timestamp = timestamp
        self.aiSuggestedReplies = aiSuggestedReplies
        self.aiInsightTip = aiInsightTip
        self.isTypingIndicator = isTypingIndicator
    }
}
