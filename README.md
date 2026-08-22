# ✨ SoulAI - Premium Native iOS Dating Application

**SoulAI** is a photography-first, editorial dating application built natively in **SwiftUI** for iOS. Designed with Apple Human Interface Guidelines and lifestyle magazine aesthetics, SoulAI pairs artificial intelligence with human emotional depth.

---

## 🎨 Design System & Philosophy

> *"AI understands your personality and helps you find meaningful connections."*

- **Theme**: Strict light-mode with a warm off-white canvas (`#FAF8F5`) and clean white surfaces.
- **Accent Color**: Deep Coral / Rose (`#FF5A7A`).
- **Typography**: Apple SF Pro serif headlines, warm charcoal body text, and refined letter-spaced metadata.
- **Anti-Dashboard Philosophy**: No large AI explanations or generic stacked boxes; replaced with large portrait photography, short emotional quotes, 3-4 clean tags, and generous white space.

---

## 📱 The 5 Core Tabs

1. **Discover (`Views/Discover/DiscoverView.swift`)**
   - 75% height full-bleed portrait photography card with 28px rounded corners and soft shadow.
   - Bottom overlay: Name & Age (`"Maya, 27"`), Subtitle (`"Architect • San Francisco"`), Compatibility (`"96% match"`), 3-4 clean tags, and one poetic quote (`"Finds beauty in ordinary moments."`).
   - Minimal floating action controls: Reject ✕, Like ♡ (in deep coral), and AI Insight ✦.

2. **Matches (`Views/Match/MatchListView.swift` & `MatchDetailView.swift`)**
   - Clean editorial grid of curated high-resonance connections.
   - Deep dive relationship synergy breakdown and natural conversation starters.

3. **Conversations (`Views/Chat/ConversationsListView.swift` & `AIChatView.swift`)**
   - iMessage-inspired clean white background with rounded message bubbles.
   - Discreet floating `"Need help replying? ✨"` button opening a bottom sheet with 3 natural conversational replies.

4. **AI Coach (`Views/Coach/DatingCoachView.swift`)**
   - Personal relationship companion: *"Your Dating Companion • Better conversations, naturally."*
   - Quick prompt chips: *"Help me start a conversation"*, *"Make my reply more playful"*, *"Understand this message"*.

5. **Profile (`Views/Profile/ProfileView.swift`)**
   - Minimalist profile: Large circular portrait, Name & Age, Essence summary (*"Creative explorer"*), 3 interest tags, and relationship goal (*"Soulmate & Long-term"*).

---

## 🚀 Running the Application

### In Xcode:
1. Open `SoulAI.xcodeproj` in Xcode:
   ```bash
   open SoulAI.xcodeproj
   ```
2. Select any iOS Simulator device (e.g., **iPhone 17 Pro** or **iPhone 16 Pro**) from the device menu at the top.
3. Press **Cmd + R** to run.

### Interactive Xcode Previews:
Open any View file (e.g. `DiscoverView.swift`, `AIChatView.swift`, `MatchDetailView.swift`) and press **Option + Cmd + Enter** to view live interactive SwiftUI Canvas previews.

---

## 📚 Project Documentation
- [01_PRD.md](DOCS/01_PRD.md) - Product Requirements Document
- [02_TRD.md](DOCS/02_TRD.md) - Technical Requirements Document
- [03_UI_UX_DESIGN.md](DOCS/03_UI_UX_DESIGN.md) - UI/UX Design System & Tokens
- [04_APP_FLOW.md](DOCS/04_APP_FLOW.md) - Application Navigation & State Flow
- [05_BACKEND_SCHEMA.md](DOCS/05_BACKEND_SCHEMA.md) - Future PostgreSQL & API Schema
- [06_IMPLEMENTATION_PLAN.md](DOCS/06_IMPLEMENTATION_PLAN.md) - Implementation Tracking
