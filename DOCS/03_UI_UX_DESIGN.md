# UI/UX Design System - SoulAI (Editorial Light Mode)

## 1. Design Philosophy
SoulAI is designed as an **editorial, lifestyle-first dating experience** that feels like a premium modern relationship companion rather than a productivity tool or generic AI utility.

### Core Feeling:
> *"AI understands your personality and helps you find meaningful connections."*

---

## 2. Color Palette & Tokens
| Token | Hex / Value | Semantic Use |
|---|---|---|
| `AppColors.accentCoral` | `#FF5A7A` | The ONE distinctive accent color (CTA, Likes, Selected Tab, Sparkles) |
| `AppColors.softPeach` | `#FFF0ED` | Subtle accent container background for quotes & insights |
| `AppColors.backgroundWarm` | `#FAF8F5` | Warm off-white canvas |
| `AppColors.surfaceWhite` | `#FFFFFF` | Clean white card and pill surfaces |
| `AppColors.surfaceNeutral` | `#F3EFEA` | Soft warm grey for unselected elements & received chat bubbles |
| `AppColors.textPrimary` | `#1C1917` | Charcoal primary text (high contrast, warm) |
| `AppColors.textSecondary` | `#78716C` | Warm grey metadata and captions |
| `AppColors.onlineGreen` | `#22C55E` | Online presence indicator |
| `AppColors.borderSubtle` | `Color.black.opacity(0.06)` | Thin, clean surface dividers |
| `AppColors.subtleShadow` | `Color.black.opacity(0.05)` | Soft Gaussian blur shadow |

---

## 3. Typography & Hierarchy (Apple SF Pro)
- **Hero Headline**: `30pt` - `34pt` Serif Bold (`.design: .serif`), used on Discover name, Match title, and headers.
- **Section Titles**: `20pt` - `24pt` Serif/Rounded Bold.
- **Body & Quotes**: `15pt` - `16pt` Regular / Italic Serif (`"Finds beauty in ordinary moments."`).
- **Metadata & Category Caps**: `11pt` - `13pt` System Medium/Bold with clean letter-spacing.

---

## 4. Reusable UI Components
- **`ProfileCard`**: 75% height hero card with full-bleed portrait photography, rounded corners (28px), subtle shadow, name overlay, 3-4 clean tags, and an elegant quote.
- **`FloatingTabBar`**: Minimal floating white capsule with subtle shadow, minimal SF icons, and coral active selection.
- **`SoulButton` / `PrimaryButton`**: Confident deep coral CTA with spring press physics (`.scaleEffect(0.98)`).
- **`TagPillView` / `InterestChip`**: Clean white/neutral capsule with subtle border, charcoal text, and coral active state.
- **`CompatibilityBadge`**: Minimal white capsule with coral sparkle and `"96% match"` score.
- **`MatchCelebrationModal`**: Emotional match overlay with overlapping circular photos, percentage, and one emotional insight sentence.
