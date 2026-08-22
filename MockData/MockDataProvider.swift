import Foundation
import SwiftUI

public struct MockDataProvider: Sendable {
    public static let sampleUser = UserProfile(
        id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
        name: "Alex",
        age: 26,
        occupation: "Product Designer & Stargazer",
        location: "San Francisco, CA",
        interests: ["Spatial Audio", "Minimalist Architecture", "Specialty Coffee", "Late Night Drives", "Philosophy", "Indie Rock"],
        traits: ["Empathetic", "Curious", "Spontaneous", "Artistic", "Witty", "Reflective"],
        intention: .longTerm,
        aiGeneratedBio: "Designing intuitive worlds by day, searching for cosmic synchronicities and genuine late-night conversations by night. Looking for someone who enjoys vinyl records, honest deep-talks over flat whites, and spontaneous road trips without a GPS.",
        personalityInsights: [
            PersonalityInsight(
                title: "Emotional Resonance",
                value: "High (94%)",
                icon: "heart.text.square.fill",
                score: 94,
                explanation: "You prioritize reciprocal vulnerability, deep listening, and intuitive emotional safety."
            ),
            PersonalityInsight(
                title: "Intellectual Curiosity",
                value: "Exceptional (98%)",
                icon: "brain.head.profile",
                score: 98,
                explanation: "Thrives when exploring conceptual ideas, design philosophy, and artistic storytelling."
            ),
            PersonalityInsight(
                title: "Spontaneity Index",
                value: "Balanced (86%)",
                icon: "sparkles",
                score: 86,
                explanation: "Values grounded daily rituals with regular doses of adventurous surprises."
            ),
            PersonalityInsight(
                title: "Communication Style",
                value: "Direct & Tender",
                icon: "bubble.left.and.bubble.right.fill",
                score: 90,
                explanation: "Warm, witty, and appreciates transparent communication without games."
            )
        ],
        avatarImageName: "person.crop.circle.fill",
        soulVibeSummary: "An empathetic visionary seeking deep intellectual intimacy and shared aesthetic wonder."
    )

    public static let sampleMatches: [MatchProfile] = [
        MatchProfile(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            name: "Maya Vance",
            age: 27,
            occupation: "Architectural Designer & Ceramicist",
            location: "San Francisco, CA",
            distanceMiles: 3,
            aiGeneratedBio: "Sculpting light, spaces, and ceramics. I believe Sunday mornings should consist of slow pourovers, ambient lo-fi, and sketching mid-century furniture.",
            vibeKeywords: ["Architectural", "Quiet Empathy", "Visual Mind", "Analog Soul"],
            interests: ["Minimalist Architecture", "Specialty Coffee", "Gallery Openings", "Ceramics", "Japan Travel"],
            traits: ["Empathetic", "Artistic", "Reflective", "Grounded", "Observant"],
            compatibilityScore: 96,
            matchReasons: [
                "Both value tactile aesthetics and thoughtful slow living",
                "Complementary emotional support cadences",
                "High overlap in Sunday morning ritual values"
            ],
            gradientThemeName: "rose",
            avatarSymbol: "sparkles",
            analysis: MatchAnalysis(
                overallScore: 96,
                matchTagline: "Golden Harmony: Spatial Thinkers with Deep Intuitive Chemistry",
                strengths: [
                    "Shared creative language: Both navigate the world through sensory and aesthetic depth.",
                    "High conversational symmetry: Equal balance of humor, listening, and playful curiosity.",
                    "Mutual respect for individual creative solitude alongside cozy co-presence."
                ],
                possibleChallenges: [
                    "Both can become absorbed in intensive creative projects; require intentional scheduled dates.",
                    "Subtle perfectionist tendencies when planning trips or shared activities."
                ],
                dimensions: [
                    CompatibilityDimension(title: "Emotional Depth", score: 98, detail: "Profound mutual understanding and safety."),
                    CompatibilityDimension(title: "Lifestyle Cadence", score: 94, detail: "Both love cozy cafes and artistic events."),
                    CompatibilityDimension(title: "Growth Alignment", score: 95, detail: "Shared ambition to build meaningful creations."),
                    CompatibilityDimension(title: "Playfulness", score: 91, detail: "Gentle teasing and warm wit.")
                ],
                aiAdviceSummary: "Maya appreciates subtle, genuine curiosity. Skip generic questions and ask her about the most memorable structure or space she has stepped into recently.",
                conversationStarters: [
                    "I noticed your passion for ceramics—what's the most challenging piece you've thrown recently?",
                    "If we had a Sunday morning in SF with no plans, which coffee spot are you taking me to first?",
                    "What's an architectural detail in the city that most people walk past without noticing?"
                ]
            ),
            hasMatched: true,
            lastActiveAgo: "Active 5m ago"
        ),
        MatchProfile(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            name: "Liam Thorne",
            age: 28,
            occupation: "AI Neuro-Researcher & Cellist",
            location: "Berkeley, CA",
            distanceMiles: 7,
            aiGeneratedBio: "Decoding synaptic patterns by day, playing Bach suites and exploring redwood trails by dusk. Let's discuss consciousness over spicy ramen.",
            vibeKeywords: ["Neuroscience", "Classical Music", "Introspective", "Trail Runner"],
            interests: ["Philosophy", "Spatial Audio", "Acoustic Cello", "Redwood Hikes", "Ramen"],
            traits: ["Curious", "Reflective", "Witty", "Calm", "Analytical"],
            compatibilityScore: 94,
            matchReasons: [
                "Both have high intellectual curiosity scores (>95%)",
                "Shared appreciation for complex acoustic & spatial soundscapes",
                "Deep desire for honest, transparent dialogue"
            ],
            gradientThemeName: "violet",
            avatarSymbol: "music.note",
            analysis: MatchAnalysis(
                overallScore: 94,
                matchTagline: "Curiosity Harmonic: Analytical Minds with Deep Artistic Tendencies",
                strengths: [
                    "Profound intellectual resonance: You will never run out of ideas to explore.",
                    "Shared auditory sensitivity: Connect deeply through music recommendations.",
                    "Calm demeanor that balances out frantic work weeks."
                ],
                possibleChallenges: [
                    "Liam is an introvert who recharges in solitude; allow natural breath between intense hangouts.",
                    "Can over-analyze relationship steps instead of leaning into spontaneous emotion."
                ],
                dimensions: [
                    CompatibilityDimension(title: "Intellectual Synergy", score: 99, detail: "Unmatched depth in conversation and philosophy."),
                    CompatibilityDimension(title: "Communication Clarity", score: 92, detail: "Honest, calm, and level-headed discussions."),
                    CompatibilityDimension(title: "Values & Ambition", score: 95, detail: "Aligned long-term growth and curiosity.")
                ],
                aiAdviceSummary: "Ask Liam about the crossover between musical harmony and neural networks—it ignites his eyes every time.",
                conversationStarters: [
                    "Do you listen to classical while coding, or does cello require its own dedicated headspace?",
                    "What's your favorite redwood trail for unplugging after a heavy research week?",
                    "Hot take: Best spicy ramen spot in the East Bay?"
                ]
            ),
            hasMatched: true,
            lastActiveAgo: "Active now"
        ),
        MatchProfile(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            name: "Elena Rostova",
            age: 26,
            occupation: "Botanical Stylist & Poet",
            location: "Oakland, CA",
            distanceMiles: 5,
            aiGeneratedBio: "Surrounded by ferns, rare monsteras, and vintage paperbacks. Seeking someone who finds magic in golden hour shadows and rainy afternoon bookstore crawls.",
            vibeKeywords: ["Botanical", "Poetic", "Gentle Soul", "Vintage Aesthetics"],
            interests: ["Specialty Coffee", "Plant Care", "Vintage Books", "Film Photography"],
            traits: ["Empathetic", "Spontaneous", "Artistic", "Dreamy"],
            compatibilityScore: 91,
            matchReasons: [
                "Vibe compatibility in slow aesthetic living",
                "High emotional safety scores",
                "Shared love for analog arts and bookstore wanderings"
            ],
            gradientThemeName: "teal",
            avatarSymbol: "leaf.fill",
            analysis: MatchAnalysis(
                overallScore: 91,
                matchTagline: "Sensory Equilibrium: Grounded Tactile Spirit with Vivid Imagination",
                strengths: [
                    "Brings a tranquil, grounding sanctuary into your routine.",
                    "Incredible conversational warmth without pretension.",
                    "Spontaneous creative dates come naturally."
                ],
                possibleChallenges: [
                    "Elena prefers fluid, unstructured plans which might test strict scheduling.",
                    "High sensitivity to environment and sound volumes."
                ],
                dimensions: [
                    CompatibilityDimension(title: "Emotional Safety", score: 96, detail: "Extremely comforting and nurturing presence."),
                    CompatibilityDimension(title: "Aesthetic Alignment", score: 93, detail: "Identical taste in warm interior spaces.")
                ],
                aiAdviceSummary: "Mention an obscure book you love or your favorite quiet corner in San Francisco.",
                conversationStarters: [
                    "If your botanical studio had a soundtrack, what album is playing on repeat?",
                    "What's the rarest plant in your collection that you're most protective over?"
                ]
            ),
            hasMatched: false,
            lastActiveAgo: "Active 1h ago"
        ),
        MatchProfile(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            name: "Julian Cruz",
            age: 29,
            occupation: "Indie Game Creative Director",
            location: "San Francisco, CA",
            distanceMiles: 2,
            aiGeneratedBio: "Building atmospheric sci-fi games with emotive soundtracks. Lover of synthwave, night cycling along the Embarcadero, and discovering hidden speakeasies.",
            vibeKeywords: ["World Builder", "Synthwave", "Late-Night Thinker", "Playful"],
            interests: ["Spatial Audio", "Indie Rock", "Sci-Fi", "Game Design", "Late Night Drives"],
            traits: ["Witty", "Spontaneous", "Curious", "Artistic"],
            compatibilityScore: 89,
            matchReasons: [
                "Identical music and night-owl lifestyle energy",
                "Shared passion for world-building and interactive design",
                "Endless witty banter potential"
            ],
            gradientThemeName: "amber",
            avatarSymbol: "gamecontroller.fill",
            analysis: MatchAnalysis(
                overallScore: 89,
                matchTagline: "World-Builders: High Playfulness and Endless Narrative Wit",
                strengths: [
                    "Instant chemistry and effortless teasing banter.",
                    "Exciting late-night explorations and creative brainstorms."
                ],
                possibleChallenges: [
                    "Can default to humor when vulnerable topics arise.",
                    "Night owl schedule might conflict with early morning productivity."
                ],
                dimensions: [
                    CompatibilityDimension(title: "Banter & Humor", score: 98, detail: "Non-stop witty sparks and inside jokes."),
                    CompatibilityDimension(title: "Shared Passions", score: 92, detail: "Creative synergy across digital arts.")
                ],
                aiAdviceSummary: "Challenge him to describe his current game concept in three emojis.",
                conversationStarters: [
                    "What video game soundtrack has the most emotional storytelling in your opinion?",
                    "Where's the best late-night spot for a sudden creative breakthrough?"
                ]
            ),
            hasMatched: false,
            lastActiveAgo: "Active 3h ago"
        )
    ]

    public static let sampleCoachCategories: [DatingCoachPromptCategory] = [
        DatingCoachPromptCategory(
            title: "First Message Icebreakers",
            icon: "sparkles",
            prompts: [
                "Craft a witty opener for Maya about architecture",
                "Ask Liam about his cello & neuroscience balance",
                "Playful icebreaker for someone who loves specialty coffee",
                "How do I stand out without sounding cheesy?"
            ]
        ),
        DatingCoachPromptCategory(
            title: "Compatibility & Synergy",
            icon: "brain.head.profile",
            prompts: [
                "Break down why Maya and I have a 96% match score",
                "How do our personality traits complement each other?",
                "What are subtle flags I should watch out for?",
                "How can we navigate our different sleep rhythms?"
            ]
        ),
        DatingCoachPromptCategory(
            title: "First Date Concept Generator",
            icon: "heart.circle.fill",
            prompts: [
                "Suggest a low-pressure creative date in SF for Maya",
                "Quiet acoustic evening date idea for Liam",
                "Cozy rain-day date plan with coffee & vinyl",
                "How do I transition from text to in-person smoothly?"
            ]
        ),
        DatingCoachPromptCategory(
            title: "Communication Rhythm & Flow",
            icon: "bubble.left.and.exclamationmark.bubble.right.fill",
            prompts: [
                "How do I revive a conversation that slowed down?",
                "Should I text first or wait for their reply?",
                "How to communicate transparently without overwhelming someone?",
                "Tips for establishing healthy boundaries early"
            ]
        )
    ]

    public static let sampleCoachAdviceCards: [DatingCoachAdviceCard] = [
        DatingCoachAdviceCard(
            title: "The 'Shared Wonder' Opener Technique",
            category: "Icebreakers",
            summary: "Instead of 'Hey how's your week', frame an observational question around their curated interests.",
            actionableSteps: [
                "Identify their top vibe keyword (e.g. Minimalist Architecture)",
                "Relate it to an experience or open mystery",
                "Keep the tone breezy, specific, and unforced"
            ],
            icon: "wand.and.stars"
        ),
        DatingCoachAdviceCard(
            title: "Navigating The First 48 Hours After Matching",
            category: "Momentum",
            summary: "High-compatibility matches flourish when conversation moves from abstract greetings to specific shared micro-stories within 3-4 exchanges.",
            actionableSteps: [
                "Acknowledge the high match score with playful humility",
                "Share an immediate mini-anecdote rather than generic pleasantries",
                "Propose a casual, low-stakes coffee date after 10-15 quality message exchanges"
            ],
            icon: "bolt.heart.fill"
        ),
        DatingCoachAdviceCard(
            title: "Deep Connection vs Interrogation",
            category: "Chemistry",
            summary: "Create emotional resonance by mirroring emotional depth instead of rattling off rapid-fire resume questions.",
            actionableSteps: [
                "Follow the 1:1 question-to-reflection rule",
                "Share why something matters to you when asking about their passions",
                "Validate emotional undertones before pivoting to new topics"
            ],
            icon: "quote.bubble.fill"
        )
    ]

    public static let sampleChatMessages: [ChatMessage] = [
        ChatMessage(
            sender: .soulAIAssistant,
            content: "✨ SoulAI Match Analysis: You and Maya share 96% compatibility. Both of you gravitate toward spatial aesthetics, quiet coffee mornings, and reflective conversations. Enjoy connecting!",
            timestamp: Calendar.current.date(byAdding: .hour, value: -3, to: Date())!,
            aiSuggestedReplies: [],
            aiInsightTip: "Tip: Maya's bio mentions sketching mid-century furniture and ceramics."
        ),
        ChatMessage(
            sender: .currentUser,
            content: "Hey Maya! Saw you're into ceramics and architecture. What's the most memorable building you've visited recently that made you stop and just admire the light?",
            timestamp: Calendar.current.date(byAdding: .minute, value: -120, to: Date())!,
            aiSuggestedReplies: [],
            aiInsightTip: nil
        ),
        ChatMessage(
            sender: .matchUser,
            content: "Oh wow, great question! Honestly, the Church of the Light by Tadao Ando in Osaka. The way the concrete cross slices natural sunlight into the dark sanctuary gave me chills.",
            timestamp: Calendar.current.date(byAdding: .minute, value: -90, to: Date())!,
            aiSuggestedReplies: [
                "Tadao Ando is legendary! Concrete and light minimalism at its finest.",
                "Have you been to the SF MOMA rooftop sculpture garden? Reminds me of that vibe.",
                "I love how natural lighting changes the entire psychology of a space."
            ],
            aiInsightTip: "💡 SoulAI Insight: High resonance detected! Maya loves Tadao Ando's minimalism. You both share visual curiosity."
        ),
        ChatMessage(
            sender: .currentUser,
            content: "Tadao Ando's mastery of concrete and natural shadow is incredible. It makes you realize architecture is as much about silence as it is about form.",
            timestamp: Calendar.current.date(byAdding: .minute, value: -45, to: Date())!,
            aiSuggestedReplies: [],
            aiInsightTip: nil
        ),
        ChatMessage(
            sender: .matchUser,
            content: "Exactly! You totally get it. Not many people appreciate that silence. Are you usually around Hayes Valley? There's this quiet little coffee spot with beautiful morning light I've been sketching at.",
            timestamp: Calendar.current.date(byAdding: .minute, value: -10, to: Date())!,
            aiSuggestedReplies: [
                "I'd love to join you there this Sunday for a sketching & coffee session!",
                "Hayes Valley is one of my favorite spots. Which cafe is it?",
                "Sounds like the ideal morning ritual. Let's make it happen!"
            ],
            aiInsightTip: "🔥 Opportunity: Maya is extending an invitation to connect in real life!"
        )
    ]
}
