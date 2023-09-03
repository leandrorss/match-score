//
//  MockMatchService.swift
//  MatchScoreTests
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import Foundation
import Combine

@testable import MatchScore
class MockMatchService: MatchServiceContract {
    
    var items: [Match] = []
    var listMatchesCalledCount: Int = 0
    
    func listMatches(videogame: MatchScore.PSVideogame, page: Int) -> AnyPublisher<[Match], Error> {
        listMatchesCalledCount += 1
        return Just(items)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
