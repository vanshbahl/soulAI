import SwiftUI
import Observation

@MainActor
@Observable
public final class DatingCoachViewModel {
    public var categories: [DatingCoachPromptCategory] = MockDataProvider.sampleCoachCategories
    public var adviceCards: [DatingCoachAdviceCard] = MockDataProvider.sampleCoachAdviceCards
    public var selectedCategoryIndex: Int = 0
    public var userQuestionInput: String = ""
    public var isAnalyzing: Bool = false
    public var coachMessages: [ChatMessage] = []

    public init() {
        self.coachMessages = [
            ChatMessage(
                sender: .coach,
                content: "👋 Hello Alex! I am your SoulAI Relationship Coach. Ask me anything about crafting genuine openers, analyzing compatibility with Maya or Liam, overcoming conversation lulls, or planning thoughtful dates.",
                timestamp: Date(),
                aiSuggestedReplies: [
                    "How should I ask Maya out for coffee without being awkward?",
                    "What makes our 96% compatibility score with Maya special?",
                    "Give me 3 creative date ideas in San Francisco."
                ]
            )
        ]
    }

    public var currentCategory: DatingCoachPromptCategory {
        categories[safe: selectedCategoryIndex] ?? categories[0]
    }

    public func selectCategory(index: Int) {
        selectedCategoryIndex = index
    }

    public func askCoach(prompt: String? = nil) {
        let question = (prompt ?? userQuestionInput).trimmingCharacters(in: .whitespacesAndNewlines)
        guard !question.isEmpty else { return }

        #if os(iOS)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        #endif

        let userMsg = ChatMessage(
            sender: .currentUser,
            content: question,
            timestamp: Date()
        )
        coachMessages.append(userMsg)
        userQuestionInput = ""
        isAnalyzing = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { [weak self] in
            guard let self = self else { return }
            self.isAnalyzing = false

            let responseContent: String
            let lower = question.lowercased()

            if lower.contains("maya") || lower.contains("coffee") || lower.contains("ask") {
                responseContent = """
                💡 **Coach Recommendation for Maya**:
                1. **Leverage Shared Rituals**: Maya's profile highlights slow Sunday mornings and specialty coffee. Frame the invite around an experience rather than an interview: *"I'm checking out Saint Frank on Sunday morning for some sketching & coffee—would love for you to join if you're free."*
                2. **Low Stakes & High Safety**: Offering a specific, daytime venue creates zero pressure while respecting her creative rhythm.
                3. **Timing**: Since you've exchanged 4 high-quality messages about Tadao Ando and architecture, the momentum is at its peak right now!
                """
            } else if lower.contains("compatibility") || lower.contains("score") || lower.contains("96%") {
                responseContent = """
                🧬 **SoulAI Compatibility Analysis Breakdown**:
                - **Strengths**: Your 96% match with Maya stems from high overlap in **Aesthetic Sensitivity** (98%) and **Conversational Cadence** (94%). You both process experiences visually and emotionally.
                - **Growth Area**: Both of you value creative deep work, so make sure to schedule intentional quality time rather than assuming spontaneous availability.
                """
            } else if lower.contains("date idea") || lower.contains("san francisco") {
                responseContent = """
                🌿 **3 Tailored Date Concepts**:
                1. **The Spatial Architecture Crawl**: Coffee at Saint Frank, followed by a walk through the Conservatory of Flowers or SF MOMA sculpture garden.
                2. **The Analog Discovery**: Exploring an independent bookstore in Hayes Valley, followed by artisanal pastry tasting.
                3. **Sunset Acoustic Lookout**: Grabbing takeout flat whites and sitting at Bernal Heights hill for golden hour city views.
                """
            } else {
                responseContent = """
                ✨ **Coach Insight**:
                Focus on emotional curiosity and vulnerability. When you share the *why* behind your passions instead of just the *what*, it gives the other person permission to meet you at the same depth.
                """
            }

            let coachReply = ChatMessage(
                sender: .coach,
                content: responseContent,
                timestamp: Date(),
                aiSuggestedReplies: [
                    "Can you rewrite my message in a more playful tone?",
                    "What should I wear for our first coffee date?",
                    "How do I know if the chemistry translated in person?"
                ]
            )
            self.coachMessages.append(coachReply)

            #if os(iOS)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            #endif
        }
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
