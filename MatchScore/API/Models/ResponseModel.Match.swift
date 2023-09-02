//
//  ResponseModel.Match.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

// MARK: - Match
struct Match {
    let id: Int
    let beginAt: String?
    let scheduledAt: String?
    let games: [Game]
    let league: League
    let serie: Serie
    let opponents: [OpponentWrapper]?
    
    var matchTime: String {
        guard let scheduledAt = scheduledAt else {
            return "TBD"
        }
        return scheduledAt.dateStringToMatchTimeFormat()
    }
    
    var leagueAndSerieName: String {
        "\(league.name) - \(serie.fullName)"
    }
    
    var IsRunning: Bool {
        games.contains(where: { $0.status == .running })
    }
}

extension Match: Identifiable { }

extension Match: Equatable {
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }
}

extension Match: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case beginAt = "begin_at"
        case scheduledAt = "scheduled_at"
        case games
        case league
        case serie
        case opponents
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(Int.self, forKey: .id)
        let beginAt = try container.decodeIfPresent(String.self, forKey: .beginAt)
        let scheduledAt = try container.decodeIfPresent(String.self, forKey: .scheduledAt)
        
        let games = try container.decode([Game].self, forKey: .games)
        let league = try container.decode(League.self, forKey: .league)
        let opponents = try container.decodeIfPresent([OpponentWrapper].self, forKey: .opponents)
        let serie = try container.decode(Serie.self, forKey: .serie)
        
        self.init(
            id: id,
            beginAt: beginAt,
            scheduledAt: scheduledAt,
            games: games,
            league: league,
            serie: serie,
            opponents: opponents
        )
    }
}

// MARK: - Game
struct Game: Decodable {
    let id: Int
    let beginAt: Date?
    let complete: Bool
    let finished: Bool
    let matchId: Int
    let status: GameStatus
    
    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case complete, endAt, finished, id
        case matchId = "match_id"
        case status
    }
    
    init(id: Int, beginAt: Date?, complete: Bool, finished: Bool, matchId: Int, status: GameStatus) {
        self.id = id
        self.beginAt = beginAt
        self.complete = complete
        self.finished = finished
        self.matchId = matchId
        self.status = status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let beginAtString = try container.decodeIfPresent(String.self, forKey: .beginAt)
        beginAt = beginAtString?.dateFromString() ?? nil
        
        complete = try container.decode(Bool.self, forKey: .complete)
        finished = try container.decode(Bool.self, forKey: .finished)
        id = try container.decode(Int.self, forKey: .id)
        matchId = try container.decode(Int.self, forKey: .matchId)
        status = try container.decode(GameStatus.self, forKey: .status)
    }
}

extension Game {
    enum GameStatus: String, Decodable {
        case notStarted = "not_started"
        case running
        case finished
        case postponed
        case canceled
    }
    
    struct Winner: Decodable {
        let id: Int
        let type: String
    }
}

// MARK: - League
struct League: Decodable {
    let id: Int
    let imageUrl: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
    }
}

// MARK: - Opponents
struct OpponentWrapper: Decodable {
    let opponent: Opponent
    let type: String
}

struct Opponent: Decodable {
    let id: Int
    let acronym: String?
    let imageUrl: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, acronym, name
        case imageUrl = "image_url"
    }
}

// MARK: - Serie
struct Serie: Decodable {
    let id: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
}
