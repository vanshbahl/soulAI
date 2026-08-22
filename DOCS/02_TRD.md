# Technical Requirements Document (TRD) - SoulAI

## 1. Technical Stack Overview
- **Language**: Swift 6.0
- **Framework**: SwiftUI (iOS 17+ / iOS 26 compatible)
- **State Management**: Observation framework (`@Observable` macro)
- **Architecture Pattern**: MVVM (Model-View-ViewModel) + Coordinator (`AppState`)
- **Package Management**: Swift Package Manager (`Package.swift`)

## 2. Architecture & Directory Structure

```
SoulAI/
├── SoulAIApp.swift               # Application lifecycle entry point
├── Theme/
│   ├── AppColors.swift           # Semantic hex colors, gradients & dark canvas
│   └── DesignTokens.swift        # Radii, glassmorphic modifiers, spacing
├── Models/
│   ├── UserProfile.swift         # User model, intentions, personality insights
│   ├── MatchProfile.swift        # AI match model, vibe tags, profile metadata
│   ├── MatchAnalysis.swift       # Strengths, challenges, dimension metrics
│   ├── ChatMessage.swift         # Chat bubbles, sender enums, suggestion pills
│   └── DatingCoachTopic.swift    # AI Coach playbooks, categories, prompts
├── MockData/
│   └── MockDataProvider.swift   # Curated sample database of matches & dialogues
├── Components/
│   ├── GlassCard.swift           # Reusable frosted glass container
│   ├── SoulButton.swift          # Gradient CTA buttons with haptics & states
│   ├── CompatibilityBadge.swift  # Pulsing score gauge pill
│   ├── TagPillView.swift         # Selectable and static trait/interest chips
│   └── BackgroundAtmosphereView.swift # Ambient floating blurred gradient orbs
├── Navigation/
│   ├── AppState.swift            # Central state & sheet coordinator
│   └── MainTabView.swift         # Floating glass tab bar
├── ViewModels/
│   ├── OnboardingViewModel.swift # Step navigation & AI bio synthesizer
│   ├── DiscoverViewModel.swift   # Swipe card physics & deck lifecycle
│   ├── MatchViewModel.swift      # Match filtering & search
│   ├── AIChatViewModel.swift     # Simulated typing & message generation
│   ├── DatingCoachViewModel.swift# Relationship advice engine
│   └── ProfileViewModel.swift    # Bio tone regeneration & profile state
└── Views/
    ├── Onboarding/OnboardingView.swift
    ├── Discover/
    │   ├── DiscoverView.swift
    │   └── Components/
    │       ├── ProfileCardView.swift
    │       └── MatchCelebrationModal.swift
    ├── Match/
    │   ├── MatchListView.swift
    │   └── MatchDetailView.swift
    ├── Chat/AIChatView.swift
    ├── Coach/DatingCoachView.swift
    └── Profile/ProfileView.swift
```

## 3. Key Design Patterns & Engineering Highlights
1. **Swift Observation**: Clean separation of state using `@Observable` classes (`AppState`, `DiscoverViewModel`, `AIChatViewModel`, etc.) without legacy `@Published` boilerplate.
2. **Gesture Physics**: `DragGesture` calculations map horizontal translation directly to dynamic rotation angles and visual threshold badges (`SOUL LIKE` / `PASS`).
3. **Simulation Engines**: Asynchronous `DispatchQueue.main.asyncAfter` routines simulate neural profile synthesis, dynamic AI bio tone rewriting, and real-time chat typing delays.
4. **Liquid Visuals & Glassmorphism**: Custom `GlassmorphicModifier` leveraging `.ultraThinMaterial`, dual-stroke gradient borders, and ambient blurred background orbs.
