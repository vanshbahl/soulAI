import SwiftUI
import Observation

@MainActor
@Observable
public final class AIChatViewModel {
    public var match: MatchProfile
    public var messages: [ChatMessage] = []
    public var inputText: String = ""
    public var isMatchTyping: Bool = false
    public var currentSuggestedReplies: [String] = []

    public init(match: MatchProfile) {
        self.match = match
        self.messages = MockDataProvider.sampleChatMessages
        if let lastWithSuggestions = MockDataProvider.sampleChatMessages.last(where: { !$0.aiSuggestedReplies.isEmpty }) {
            self.currentSuggestedReplies = lastWithSuggestions.aiSuggestedReplies
        }
    }

    public func sendMessage(_ customText: String? = nil) {
        let textToSend = (customText ?? inputText).trimmingCharacters(in: .whitespacesAndNewlines)
        guard !textToSend.isEmpty else { return }

        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif

        let userMsg = ChatMessage(
            sender: .currentUser,
            content: textToSend,
            timestamp: Date()
        )
        messages.append(userMsg)
        inputText = ""
        currentSuggestedReplies = []

        // Simulate AI Match typing & response
        simulateMatchReply(to: textToSend)
    }

    public func selectSuggestedReply(_ reply: String) {
        sendMessage(reply)
    }

    private func simulateMatchReply(to userText: String) {
        isMatchTyping = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) { [weak self] in
            guard let self = self else { return }
            self.isMatchTyping = false

            let replyContent: String
            let suggestedReplies: [String]
            let insightTip: String?

            let lower = userText.lowercased()
            if lower.contains("coffee") || lower.contains("sunday") || lower.contains("hayes") {
                replyContent = "Let's do Saint Frank Coffee on Polk or Ritual in Hayes! Sunday around 11 AM works perfectly for me. Shall we grab a corner table with good light?"
                suggestedReplies = [
                    "Saint Frank on Polk sounds wonderful! Sunday at 11 AM is locked in.",
                    "Ritual has incredible pourovers. Can't wait to see your sketchbook!",
                    "11 AM is perfect. Looking forward to meeting you in person!"
                ]
                insightTip = "🎯 Match Milestone: Date confirmed! You have established an authentic real-world connection."
            } else if lower.contains("architecture") || lower.contains("tadao") || lower.contains("design") {
                replyContent = "I love how you view design through the lens of human experience. It's rare to meet someone who truly cares about the poetry of spatial proportion."
                suggestedReplies = [
                    "Good design is basically frozen empathy. What project are you working on currently?",
                    "Have you ever thought about designing your own studio retreat?",
                    "That's such a generous compliment. I feel like our creative wavelengths just aligned."
                ]
                insightTip = "✨ High emotional sync: Shared aesthetic values."
            } else {
                replyContent = "That resonates with me so much! I was just reflecting on something similar earlier today. Tell me more about what inspired that thought?"
                suggestedReplies = [
                    "It started during a quiet morning walk today.",
                    "I think when you slow down, those insights just surface naturally.",
                    "Would love to unpack that more over coffee this weekend!"
                ]
                insightTip = nil
            }

            let matchMsg = ChatMessage(
                sender: .matchUser,
                content: replyContent,
                timestamp: Date(),
                aiSuggestedReplies: suggestedReplies,
                aiInsightTip: insightTip
            )
            self.messages.append(matchMsg)
            self.currentSuggestedReplies = suggestedReplies

            #if os(iOS)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            #endif
        }
    }
}
