# UI/UX Design System - SoulAI

## 1. Visual Philosophy
SoulAI combines **Apple Human Interface Guidelines** with a modern luxury dark-mode aesthetic. The interface evokes intimacy, curiosity, and high-tech intelligence through deep obsidian backgrounds punctuated by electric rose, cyber violet, and glowing aurora teal accents.

## 2. Color Palette & Gradients
| Token | Hex / Value | Semantic Use |
|---|---|---|
| `AppColors.primaryRose` | `#FF2E63` | Primary brand accent, Like actions, heart highlights |
| `AppColors.electricViolet` | `#7928CA` | Neural accents, gradient transitions |
| `AppColors.auroraTeal` | `#00F5D4` | AI Synergy, active match badges, super likes |
| `AppColors.sunsetAmber` | `#FF9E38` | Rewind actions, challenges & warnings |
| `AppColors.backgroundDark` | `#0B0D14` | Midnight obsidian canvas |
| `AppColors.cardSurface` | `#171C2B` | Elevated glass card backgrounds |
| `AppColors.soulGradient` | Rose to Violet | Main CTA buttons, active state chips, hero titles |

## 3. Typography & Hierarchy
- **Title 1 / Headers**: Rounded Bold / Black (`28pt` - `32pt`), high-impact branding.
- **Section Headers**: Rounded Semi-Bold (`18pt`), clear visual grouping.
- **Category Caps**: System Bold (`11pt`), uppercase with soft lilac color.
- **Body Text**: System Regular / Medium (`13pt` - `15pt`), clean legibility with `1.4` line-height spacing.

## 4. Components & Micro-Interactions
- **`GlassCard`**: Frosted glass card with 1px border stroke and deep drop shadow.
- **`SoulButton`**: Spring press scaling (`0.97` factor), haptic impact generator (`UIImpactFeedbackGenerator`), and soft glow.
- **`CompatibilityBadge`**: Pulsing animated ring with repeating sparkle SF symbol.
- **`BackgroundAtmosphereView`**: 3 floating blurred orbs oscillating on 8-second continuous ease loops.
- **Card Swipe Feedback**: Dynamic rotation `degrees(offset.width / 18)` with threshold badges.
