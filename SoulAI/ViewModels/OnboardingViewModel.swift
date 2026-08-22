import SwiftUI
import Observation

public enum OnboardingStep: Int, CaseIterable {
    case basicInfo = 0
    case interests = 1
    case personalityTraits = 2
    case intention = 3
    case aiSynthesis = 4
}

@MainActor
@Observable
public final class OnboardingViewModel {
    public var currentStep: OnboardingStep = .basicInfo
    public var name: String = "Alex"
    public var age: Int = 26
    public var occupation: String = "Product Designer"
    public var location: String = "San Francisco, CA"
    public var selectedInterests: Set<String> = ["Spatial Audio", "Minimalist Architecture", "Specialty Coffee", "Philosophy"]
    public var selectedTraits: Set<String> = ["Empathetic", "Curious", "Spontaneous", "Artistic"]
    public var selectedIntention: DatingIntention = .longTerm
    
    // AI Synthesis state
    public var isSynthesizing: Bool = false
    public var synthesisProgress: Double = 0.0
    public var generatedBio: String = ""
    public var generatedInsights: [PersonalityInsight] = []
    public var soulVibeSummary: String = ""

    public let availableInterests = [
        "Specialty Coffee", "Minimalist Architecture", "Spatial Audio", "Indie Rock",
        "Philosophy", "Ceramics", "Japan Travel", "Redwood Hikes", "Analog Synth",
        "Vintage Books", "Film Photography", "Late Night Drives", "Contemporary Art",
        "Spicy Ramen", "Astronomy", "Jazz Vinyl"
    ]

    public let availableTraits = [
        "Empathetic", "Curious", "Spontaneous", "Artistic", "Witty",
        "Reflective", "Grounded", "Ambitious", "Playful", "Calm",
        "Direct", "Introspective", "Optimistic", "Passionate"
    ]

    public init() {}

    public var canProceed: Bool {
        switch currentStep {
        case .basicInfo:
            return !name.trimmingCharacters(in: .whitespaces).isEmpty && age >= 18
        case .interests:
            return selectedInterests.count >= 2
        case .personalityTraits:
            return selectedTraits.count >= 2
        case .intention:
            return true
        case .aiSynthesis:
            return !isSynthesizing && !generatedBio.isEmpty
        }
    }

    public func toggleInterest(_ interest: String) {
        if selectedInterests.contains(interest) {
            selectedInterests.remove(interest)
        } else {
            selectedInterests.insert(interest)
        }
    }

    public func toggleTrait(_ trait: String) {
        if selectedTraits.contains(trait) {
            selectedTraits.remove(trait)
        } else {
            selectedTraits.insert(trait)
        }
    }

    public func nextStep() {
        if let next = OnboardingStep(rawValue: currentStep.rawValue + 1) {
            currentStep = next
            if next == .aiSynthesis {
                startAISynthesis()
            }
        }
    }

    public func previousStep() {
        if let prev = OnboardingStep(rawValue: currentStep.rawValue - 1) {
            currentStep = prev
        }
    }

    public func startAISynthesis() {
        isSynthesizing = true
        synthesisProgress = 0.1

        // Simulate multi-step AI neural synthesis
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.synthesisProgress = 0.45
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.synthesisProgress = 0.8
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            let interestsList = self.selectedInterests.prefix(3).joined(separator: ", ")
            self.generatedBio = "Designing intentional spaces and experiences. Believer in late-night vulnerability, slow Sunday brews, and finding cosmic resonance through \(interestsList)."
            self.soulVibeSummary = "High emotional resonance & curious artistic mindset looking for a genuine soul connection."
            self.generatedInsights = [
                PersonalityInsight(
                    title: "Emotional Resonance",
                    value: "94% Sync",
                    icon: "heart.text.square.fill",
                    score: 94,
                    explanation: "Deeply in tune with emotional nuance and empathetic communication."
                ),
                PersonalityInsight(
                    title: "Curiosity Index",
                    value: "96% Sync",
                    icon: "brain.head.profile",
                    score: 96,
                    explanation: "Drawn to passionate minds and unconventional perspectives."
                ),
                PersonalityInsight(
                    title: "Authenticity Quotient",
                    value: "91% Sync",
                    icon: "sparkles",
                    score: 91,
                    explanation: "Prefers transparent dialogue over dating games."
                )
            ]
            self.synthesisProgress = 1.0
            self.isSynthesizing = false
        }
    }

    public func buildProfile() -> UserProfile {
        UserProfile(
            name: name.isEmpty ? "Alex" : name,
            age: age,
            occupation: occupation.isEmpty ? "Product Designer" : occupation,
            location: location.isEmpty ? "San Francisco" : location,
            personalitySummary: soulVibeSummary.isEmpty ? "Creative explorer" : soulVibeSummary,
            interests: Array(selectedInterests),
            traits: Array(selectedTraits),
            intention: selectedIntention,
            quote: "Designing spaces with intention and looking for genuine conversations.",
            personalityInsights: generatedInsights.isEmpty ? MockDataProvider.sampleUser.personalityInsights : generatedInsights
        )
    }
}
