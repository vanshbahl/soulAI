# Future Backend & API Schema Specifications - SoulAI

## 1. Overview
While the prototype operates entirely on local mock models and real-time simulators in SwiftUI, the data structures are designed for seamless integration with a future FastAPI/PostgreSQL or GraphQL backend.

## 2. Relational Database Schema (PostgreSQL)

```sql
-- Users & AI Profiles
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    age INT NOT NULL CHECK (age >= 18),
    occupation VARCHAR(200),
    location VARCHAR(200),
    latitude FLOAT,
    longitude FLOAT,
    intention VARCHAR(50) NOT NULL,
    ai_generated_bio TEXT,
    soul_vibe_summary TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User Interests & Traits
CREATE TABLE user_tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    tag_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL -- 'interest' or 'trait'
);

-- Personality Resonance Insights
CREATE TABLE personality_insights (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(100) NOT NULL,
    dimension_score INT NOT NULL CHECK (dimension_score BETWEEN 0 AND 100),
    value_label VARCHAR(100),
    icon VARCHAR(100),
    explanation TEXT
);

-- Swipes & Matches
CREATE TABLE user_swipes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    initiator_id UUID REFERENCES users(id) ON DELETE CASCADE,
    target_id UUID REFERENCES users(id) ON DELETE CASCADE,
    direction VARCHAR(20) NOT NULL, -- 'like', 'pass', 'super_like'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(initiator_id, target_id)
);

CREATE TABLE matches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_a UUID REFERENCES users(id) ON DELETE CASCADE,
    user_b UUID REFERENCES users(id) ON DELETE CASCADE,
    compatibility_score INT NOT NULL,
    match_tagline TEXT,
    strengths JSONB,
    challenges JSONB,
    dimensions JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Chat Messages
CREATE TABLE chat_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    match_id UUID REFERENCES matches(id) ON DELETE CASCADE,
    sender_id UUID REFERENCES users(id) ON DELETE CASCADE,
    sender_type VARCHAR(50) NOT NULL, -- 'user', 'match', 'ai_assistant', 'coach'
    content TEXT NOT NULL,
    suggested_replies JSONB,
    insight_tip TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## 3. Future API Endpoints
- `POST /api/v1/auth/onboarding` - Submit user info, interests, traits, intention & generate AI bio.
- `POST /api/v1/ai/synthesize-bio` - Regenerate bio in specific tones (poetic, witty, direct).
- `GET /api/v1/discover/deck` - Fetch recommended profiles with compatibility scores.
- `POST /api/v1/discover/swipe` - Record swipe (like/pass/super_like) & return match payload.
- `GET /api/v1/matches/{match_id}/analysis` - Get multi-dimensional compatibility breakdown.
- `POST /api/v1/coach/ask` - Query AI dating coach with relationship questions.
