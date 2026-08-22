import Foundation
import SwiftUI

public struct MockDataProvider: Sendable {
    public static let sampleUser = UserProfile(
        id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
        name: "Alex",
        age: 26,
        occupation: "Product Designer",
        location: "San Francisco",
        personalitySummary: "Creative explorer",
        interests: ["Architecture", "Coffee", "Vinyl"],
        traits: ["Empathetic", "Curious", "Reflective"],
        intention: .longTerm,
        quote: "Designing spaces with intention and looking for genuine conversations.",
        personalityInsights: [
            PersonalityInsight(
                title: "Emotional Depth",
                value: "High",
                icon: "heart.fill",
                score: 94,
                explanation: "Values reciprocal vulnerability and deep listening."
            ),
            PersonalityInsight(
                title: "Curiosity",
                value: "Exceptional",
                icon: "sparkles",
                score: 98,
                explanation: "Thrives when exploring thoughtful ideas and design philosophy."
            )
        ]
    )

    public static let sampleMatches: [MatchProfile] = [
        MatchProfile(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            name: "Maya",
            age: 27,
            occupation: "Architect",
            location: "San Francisco",
            distanceMiles: 3,
            quote: "Finds beauty in ordinary moments.",
            personalitySummary: "Architectural visionary with a quiet contemplative soul.",
            tags: ["Architecture", "Coffee", "Travel", "Design"],
            compatibilityScore: 96,
            emotionalInsight: "You both value creativity, slow mornings and meaningful conversations.",
            avatarSymbol: "person.crop.circle.fill",
            photoGradientStartHex: "#E5989B",
            photoGradientEndHex: "#6D597A",
            analysis: MatchAnalysis(
                overallScore: 96,
                matchTagline: "Deep Creative Synergy",
                strengths: [
                    "Shared appreciation for spatial design and slow mornings",
                    "High conversational symmetry and mutual curiosity",
                    "Mutual respect for creative focus and quiet co-presence"
                ],
                possibleChallenges: [
                    "Both can become deeply immersed in work; requires intentional dates"
                ],
                dimensions: [
                    CompatibilityDimension(title: "Emotional Depth", score: 98, detail: "Profound mutual understanding."),
                    CompatibilityDimension(title: "Lifestyle Cadence", score: 94, detail: "Love for cozy cafes and galleries.")
                ],
                aiAdviceSummary: "Maya loves Tadao Ando and quiet coffee spots. Ask about her favorite building in SF.",
                conversationStarters: [
                    "What's your favorite corner in San Francisco for quiet sketching?",
                    "Which coffee shop has the best natural morning light?"
                ]
            ),
            hasMatched: true,
            lastActiveAgo: "Active now"
        ),
        MatchProfile(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            name: "Liam",
            age: 28,
            occupation: "Cellist & Researcher",
            location: "Berkeley",
            distanceMiles: 7,
            quote: "Listening to the rhythm beneath the noise.",
            personalitySummary: "Classical musician exploring neural soundscapes.",
            tags: ["Music", "Philosophy", "Outdoors", "Coffee"],
            compatibilityScore: 94,
            emotionalInsight: "Shared intellectual curiosity and love for acoustic tranquility.",
            avatarSymbol: "person.crop.circle.fill",
            photoGradientStartHex: "#B5838D",
            photoGradientEndHex: "#355070",
            analysis: MatchAnalysis(
                overallScore: 94,
                matchTagline: "Curiosity Harmonic",
                strengths: [
                    "Profound intellectual resonance in late-night discussions",
                    "Shared auditory sensitivity and passion for acoustic sound"
                ],
                possibleChallenges: [
                    "Introverted rhythm; allow natural breathing space between hangouts"
                ],
                dimensions: [
                    CompatibilityDimension(title: "Intellectual Synergy", score: 99, detail: "Unmatched conversational depth.")
                ],
                aiAdviceSummary: "Ask Liam about how music harmony connects with mindfulness.",
                conversationStarters: [
                    "What piece of music always resets your mind after a long week?"
                ]
            ),
            hasMatched: true,
            lastActiveAgo: "Active 10m ago"
        ),
        MatchProfile(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            name: "Elena",
            age: 26,
            occupation: "Ceramicist",
            location: "Oakland",
            distanceMiles: 5,
            quote: "Shaping memories out of clay and light.",
            personalitySummary: "Tactile artist with a tranquil, poetic spirit.",
            tags: ["Ceramics", "Books", "Plants", "Photography"],
            compatibilityScore: 91,
            emotionalInsight: "Natural conversational ease and grounded mindful living.",
            avatarSymbol: "person.crop.circle.fill",
            photoGradientStartHex: "#E07A5F",
            photoGradientEndHex: "#3D405B",
            analysis: MatchAnalysis(
                overallScore: 91,
                matchTagline: "Grounded Equilibrium",
                strengths: [
                    "Calm, comforting presence without pretense",
                    "Shared appreciation for slow analog living"
                ],
                possibleChallenges: [
                    "Elena prefers fluid unscripted plans"
                ],
                dimensions: [
                    CompatibilityDimension(title: "Emotional Safety", score: 96, detail: "Extremely comforting connection.")
                ],
                aiAdviceSummary: "Mention a quiet bookstore or vintage cafe you love.",
                conversationStarters: [
                    "What's the most challenging ceramic piece you've made recently?"
                ]
            ),
            hasMatched: false,
            lastActiveAgo: "Active 1h ago"
        ),
        MatchProfile(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            name: "Julian",
            age: 29,
            occupation: "Creative Director",
            location: "San Francisco",
            distanceMiles: 2,
            quote: "Building worlds where stories come alive.",
            personalitySummary: "Interactive storyteller and late-night thinker.",
            tags: ["Design", "Sci-Fi", "Music", "Night Drives"],
            compatibilityScore: 89,
            emotionalInsight: "High playfulness, quick wit, and shared creative energy.",
            avatarSymbol: "person.crop.circle.fill",
            photoGradientStartHex: "#F4A261",
            photoGradientEndHex: "#264653",
            analysis: MatchAnalysis(
                overallScore: 89,
                matchTagline: "Playful Storytellers",
                strengths: [
                    "Effortless teasing banter and creative synergy"
                ],
                possibleChallenges: [
                    "Night owl schedule might conflict with early morning routines"
                ],
                dimensions: [
                    CompatibilityDimension(title: "Banter & Chemistry", score: 98, detail: "Quick sparks and inside jokes.")
                ],
                aiAdviceSummary: "Challenge him to name his top atmospheric soundtrack.",
                conversationStarters: [
                    "What soundtrack tells the best emotional story in your opinion?"
                ]
            ),
            hasMatched: false,
            lastActiveAgo: "Active 3h ago"
        )
    ]

    public static let sampleCoachCategories: [DatingCoachPromptCategory] = [
        DatingCoachPromptCategory(
            title: "Start a Conversation",
            icon: "bubble.left.and.bubble.right",
            prompts: [
                "Help me start a conversation with Maya",
                "Ask Liam about his cello and research",
                "How to break the ice without sounding generic"
            ]
        ),
        DatingCoachPromptCategory(
            title: "Refine My Tone",
            icon: "sparkles",
            prompts: [
                "Make my reply more playful",
                "How to sound warm and concise",
                "Suggest a thoughtful follow-up"
            ]
        ),
        DatingCoachPromptCategory(
            title: "Date Suggestions",
            icon: "heart",
            prompts: [
                "Suggest a low-pressure coffee date in SF",
                "Quiet acoustic evening plan for Liam",
                "How to transition from chat to in-person"
            ]
        )
    ]

    public static let sampleCoachAdviceCards: [DatingCoachAdviceCard] = [
        DatingCoachAdviceCard(
            title: "The Shared Wonder Opener",
            category: "Icebreakers",
            summary: "Ask an observational question around a specific interest they care about.",
            actionableSteps: [
                "Notice their top tag (e.g. Architecture)",
                "Frame a genuine open-ended question"
            ],
            icon: "wand.and.stars"
        ),
        DatingCoachAdviceCard(
            title: "Natural Conversational Rhythm",
            category: "Momentum",
            summary: "Match their emotional depth and propose casual coffee after 8-10 meaningful exchanges.",
            actionableSteps: [
                "Share why something matters to you",
                "Propose a relaxed daytime spot"
            ],
            icon: "heart.fill"
        )
    ]

    public static let sampleChatMessages: [ChatMessage] = [
        ChatMessage(
            sender: .matchUser,
            content: "Hey Alex! Loved your note on minimalism. Have you ever visited the Church of the Light in Osaka?",
            timestamp: Calendar.current.date(byAdding: .minute, value: -120, to: Date())!,
            aiSuggestedReplies: [
                "Tadao Ando's work is legendary! The way light cuts through the concrete is magic.",
                "I haven't yet, but it's top of my travel wishlist. Have you been?",
                "The quiet power of natural light in architecture is unmatched."
            ],
            aiInsightTip: "Maya loves Tadao Ando's minimalism."
        ),
        ChatMessage(
            sender: .currentUser,
            content: "Tadao Ando is legendary! Concrete and natural shadow make architecture feel like poetry.",
            timestamp: Calendar.current.date(byAdding: .minute, value: -60, to: Date())!,
            aiSuggestedReplies: []
        ),
        ChatMessage(
            sender: .matchUser,
            content: "Exactly! There's a quiet cafe in Hayes Valley with that exact morning light. Are you free Sunday?",
            timestamp: Calendar.current.date(byAdding: .minute, value: -10, to: Date())!,
            aiSuggestedReplies: [
                "Sunday morning at that cafe sounds perfect. Let's do it!",
                "I'd love to! What time works best for you?",
                "You picked my favorite neighborhood. Looking forward to it!"
            ],
            aiInsightTip: "Maya is inviting you out for coffee on Sunday."
        )
    ]
}
