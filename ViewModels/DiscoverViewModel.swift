import SwiftUI
import Observation

public enum SwipeDirection {
    case left  // Pass
    case right // Like
    case up    // Super Like / Deep Match
}

@Observable
public final class DiscoverViewModel {
    public var deck: [MatchProfile] = []
    public var swipedHistory: [(profile: MatchProfile, direction: SwipeDirection)] = []
    public var cardOffset: CGSize = .zero
    public var isDragging: Bool = false
    public var showMatchModal: Bool = false
    public var matchedProfile: MatchProfile? = nil

    public let swipeThreshold: CGFloat = 130

    public init() {
        self.deck = MockDataProvider.sampleMatches
    }

    public var topProfile: MatchProfile? {
        deck.first
    }

    public var nextProfile: MatchProfile? {
        deck.count > 1 ? deck[1] : nil
    }

    public func updateOffset(_ translation: CGSize) {
        cardOffset = translation
        isDragging = true
    }

    public func endOffset() -> SwipeDirection? {
        isDragging = false
        if cardOffset.width > swipeThreshold {
            return .right
        } else if cardOffset.width < -swipeThreshold {
            return .left
        } else if cardOffset.height < -swipeThreshold {
            return .up
        } else {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                cardOffset = .zero
            }
            return nil
        }
    }

    public func swipeCard(direction: SwipeDirection, onMatch: ((MatchProfile) -> Void)? = nil) {
        guard let profile = deck.first else { return }

        #if os(iOS)
        switch direction {
        case .right:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .left:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .up:
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        }
        #endif

        let targetX: CGFloat = direction == .right ? 500 : (direction == .left ? -500 : 0)
        let targetY: CGFloat = direction == .up ? -600 : 0

        withAnimation(.easeOut(duration: 0.28)) {
            cardOffset = CGSize(width: targetX, height: targetY)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
            self.swipedHistory.append((profile, direction))
            self.deck.removeFirst()
            self.cardOffset = .zero

            if direction == .right || direction == .up {
                self.matchedProfile = profile
                self.showMatchModal = true
                onMatch?(profile)
            }
        }
    }

    public func undoSwipe() {
        guard let last = swipedHistory.popLast() else { return }
        deck.insert(last.profile, at: 0)
        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
            cardOffset = .zero
        }
    }

    public func reloadDeck() {
        deck = MockDataProvider.sampleMatches
        swipedHistory.removeAll()
        cardOffset = .zero
    }
}
