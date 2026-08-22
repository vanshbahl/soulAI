import SwiftUI
import Observation

public enum MatchFilter: String, CaseIterable, Identifiable {
    case all = "All Matches"
    case highSync = "90%+ Soul Sync"
    case active = "Active Today"

    public var id: String { rawValue }
}

@MainActor
@Observable
public final class MatchViewModel {
    public var filter: MatchFilter = .all
    public var searchQuery: String = ""

    public init() {}

    public func filteredMatches(from matches: [MatchProfile]) -> [MatchProfile] {
        matches.filter { match in
            let matchesQuery = searchQuery.isEmpty || match.name.localizedCaseInsensitiveContains(searchQuery) || match.occupation.localizedCaseInsensitiveContains(searchQuery)
            
            switch filter {
            case .all:
                return matchesQuery
            case .highSync:
                return matchesQuery && match.compatibilityScore >= 90
            case .active:
                return matchesQuery && match.lastActiveAgo.contains("m") || match.lastActiveAgo.contains("now")
            }
        }
    }
}
