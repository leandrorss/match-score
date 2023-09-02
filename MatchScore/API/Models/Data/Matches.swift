//
//  Matches.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

extension Match {
    
    static let matches: [Match] = [match]
    
    static let match: Match = .init(
        id: 1133,
        beginAt: "2023-04-10T17:00:00Z",
        scheduledAt: "2023-04-10T17:00:00Z",
        games: [
            .init(
                id: 111750,
                beginAt: nil,
                complete: false,
                finished: false,
                matchId: 111750,
                status: .notStarted
            )
        ],
        league: .init(
            id: 4554,
            imageUrl: "https://cdn.pandascore.co/images/league/image/4554/Liga_Gamers_Club_SSrie_A_logo.png",
            name: "Gamers Club Liga Série A"
        ),
        serie: .init(id: 4844, fullName: "Season 6 2022"),
        opponents: [
            .init(opponent: .init(id: 133477, acronym: nil, imageUrl: nil, name: "QM"), type: "Team"),
            .init(opponent: .init(id: 129539, acronym: nil, imageUrl: nil, name: "Websterz"), type: "Team")
        ]
    )
}
