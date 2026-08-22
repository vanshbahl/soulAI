# ✨ SoulAI - Native SwiftUI AI Dating App Prototype

**SoulAI** is a visually impressive, native iOS SwiftUI prototype designed around artificial intelligence, deep psychological synergy, and modern Apple Human Interface Guidelines.

---

## 📱 Features & Implemented Screens

1. **OnboardingView (`Views/Onboarding/OnboardingView.swift`)**
   - 5-step guided onboarding: Name, Age, Occupation, Location.
   - Interactive curiosity tags & essence trait selectors.
   - Explicit dating intention selector.
   - Animated AI profile synthesis with real-time bio preview.

2. **DiscoverView (`Views/Discover/DiscoverView.swift`)**
   - Tinder-style swipe card stack with physics-based drag & rotation.
   - Real-time `SOUL LIKE` and `PASS` threshold overlays.
   - Compatibility score badge and AI match reasons highlight.
   - Action controls: Rewind ⏪, Pass ❌, Super Like 🌟, Like ❤️.
   - Animated "It's a Soul Match!" celebration modal.

3. **MatchListView & MatchDetailView (`Views/Match/`)**
   - Filterable matches queue (All, 90%+ Soul Sync, Active).
   - Deep dive compatibility analysis:
     - Overall compatibility score gauge.
     - Relationship strengths breakdown.
     - Possible growth challenges.
     - Multi-dimensional scoring (Emotional Depth, Lifestyle Cadence, Growth Alignment, Playfulness).
     - AI conversation starters.

4. **AIChatView (`Views/Chat/AIChatView.swift`)**
   - Simulated AI match conversation.
   - Realistic typing indicator bubbles.
   - 1-tap smart AI suggested replies.
   - Real-time dating coach insight tips embedded in chat.

5. **DatingCoachView (`Views/Coach/DatingCoachView.swift`)**
   - AI relationship advice categories (Icebreakers, Compatibility, Date Concepts, Communication Rhythm).
   - Actionable relationship playbooks carousel.
   - Interactive Q&A chat stream answering custom relationship queries.

6. **ProfileView (`Views/Profile/ProfileView.swift`)**
   - AI-generated soul bio display.
   - Instant AI tone switcher (Balanced & Warm, Poetic & Deep, Witty & Playful, Direct & Minimal).
   - Personality insight score gauges.
   - Demo reset utility to easily re-run the onboarding experience.

---

## 🎨 Design System & Aesthetics
- **Luxury Dark Atmosphere**: Midnight obsidian canvas (`#0B0D14`) with floating ambient blurred gradient orbs.
- **Glassmorphism**: `.ultraThinMaterial` surfaces with dual-stroke gradient borders and soft drop shadows.
- **Vibrant Accent Palette**: Electric Rose (`#FF2E63`), Cyber Violet (`#7928CA`), Aurora Teal (`#00F5D4`), Sunset Amber (`#FF9E38`).
- **Tactile Feedback**: Haptic feedback on buttons, card swipes, and smart reply selection.

---

## 🏗 Architecture
- **Framework**: Native SwiftUI (iOS 17+ / iOS 26)
- **State Management**: Swift Observation framework (`@Observable` macro)
- **Pattern**: MVVM (Model-View-ViewModel) + Central `AppState` Coordinator
- **Mock Data**: Rich, realistic database in `MockDataProvider.swift`

---

## 🚀 How to Run

### In Xcode:
1. Open the `SoulAI` directory in Xcode (or double click `Package.swift`).
2. Select an iOS Simulator (e.g. iPhone 16 Pro / iPhone 17) and press **Cmd + R** to run.

### Via Command Line / SwiftPM:
```bash
cd SoulAI
swift test # or build for target simulator
```

---

## 📚 Project Documentation
- [01_PRD.md](DOCS/01_PRD.md) - Product Requirements Document
- [02_TRD.md](DOCS/02_TRD.md) - Technical Requirements Document
- [03_UI_UX_DESIGN.md](DOCS/03_UI_UX_DESIGN.md) - UI/UX Design System & Tokens
- [04_APP_FLOW.md](DOCS/04_APP_FLOW.md) - Application Navigation & State Flow
- [05_BACKEND_SCHEMA.md](DOCS/05_BACKEND_SCHEMA.md) - Future PostgreSQL & API Schema
- [06_IMPLEMENTATION_PLAN.md](DOCS/06_IMPLEMENTATION_PLAN.md) - Phased Implementation Plan
