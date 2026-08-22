# Product Requirements Document (PRD) - SoulAI

## 1. Executive Summary
**SoulAI** is a native iOS dating application prototype engineered around artificial intelligence, emotional resonance, and deep personality synergy. Unlike conventional superficial dating apps, SoulAI uses neural synthesis to generate expressive user bios, analyze psychological compatibility across multiple dimensions, provide simulated conversational chemistry, and offer an AI Dating Coach for real-time relationship guidance.

## 2. Product Objectives
- **Demonstrate AI-Powered Matching**: Provide transparent, multi-dimensional compatibility scores (strengths, growth areas, values synergy).
- **Deliver Modern Apple Design**: Feature luxury dark-mode aesthetics, fluid glassmorphism, sensory haptic feedback, and dynamic card gestures.
- **Simulate Rich Conversational Interaction**: Realistic message exchange with typing indicators, AI suggestions, and relationship milestone tracking.
- **Provide Actionable Coaching**: Dedicated AI Dating Coach with actionable relationship playbooks and real-time advice.

## 3. Target Audience & Personas
- **Curious Creatives & Thinkers**: Individuals seeking authentic connection beyond superficial swipe decks.
- **Mindful Daters**: Users who value transparent communication, shared daily rituals, and psychological alignment.

## 4. Key Feature Requirements

### 4.1 Onboarding & Neural Profile Synthesis (`OnboardingView`)
- **Step 1 - Basic Info**: Name, age (validation >= 18), occupation/craft, location.
- **Step 2 - Curiosity & Interests**: Interactive selectable tag cloud (minimum 2 selections).
- **Step 3 - Essence Traits**: Core personality attributes (minimum 2 selections).
- **Step 4 - Dating Intention**: Explicit intention alignment (e.g. Long-term, Deep Connection, Thoughtful Dating).
- **Step 5 - AI Bio & Insight Synthesis**: Animated generation of a custom bio and 3+ multi-dimensional personality resonance scores.

### 4.2 AI Discover Deck (`DiscoverView`)
- **Tinder-Style Gestures**: Drag, tilt rotation physics, threshold detection.
- **Feedback Overlays**: Dynamic glowing `SOUL LIKE` (teal) and `PASS` (rose) stamps.
- **Card Content**: Photo avatar badge, name, age, distance, occupation, AI match reasons box, vibe hashtags, and direct compatibility gauge.
- **Action Controls**: Rewind (undo last swipe), Pass (swipe left), Super Like / Deep Soul Sync (swipe up), Like (swipe right).
- **Celebration Modal**: Animated celebration modal upon matching with quick-start chat CTA.

### 4.3 Match Analysis & Deep Dive (`MatchDetailView` & `MatchListView`)
- **Match Queue**: Filterable by All, 90%+ Soul Sync, and Active.
- **Compatibility Breakdown**:
  - Overall match gauge (e.g. 96%).
  - AI match tagline.
  - Bulleted relationship strengths.
  - Bulleted possible growth challenges.
  - Multi-dimensional scoring bars (Emotional Depth, Lifestyle Cadence, Growth Alignment, Playfulness).
  - Contextual AI conversation starters with 1-tap copy/chat actions.

### 4.4 Simulated AI Chat (`AIChatView`)
- **Live Conversational Flow**: Simulated typing delays and realistic responses.
- **AI Suggested Replies**: 1-tap contextual reply pills.
- **AI Insight Ribbons**: Real-time dating coach tips embedded in conversation bubbles.
- **Milestone Detection**: Automated detection of real-world date coordination.

### 4.5 AI Dating Coach (`DatingCoachView`)
- **Category Guidance**: First Message Icebreakers, Compatibility & Synergy, Date Concepts, Communication Rhythm.
- **Relationship Playbooks**: Card carousel with actionable steps.
- **Q&A Chat Stream**: Interactive coach message drawer answering custom user relationship questions.

### 4.6 User Profile & AI Tone Refiner (`ProfileView`)
- **AI Generated Bio Display**: With instant tone switcher (Balanced & Warm, Poetic & Deep, Witty & Playful, Direct & Minimal).
- **Personality Insights Gauges**: Emotional Resonance, Intellectual Curiosity, Spontaneity, Communication Style.
- **Demo Utility**: Button to re-trigger onboarding flow.
