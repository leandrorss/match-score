//
//  MatchService.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation
import Combine

protocol MatchServiceContract {
    func listMatches(videogame: PSVideogame, page: Int) -> AnyPublisher<[Match], Error>
}

class MatchService: MatchServiceContract {
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func listMatches(videogame: PSVideogame, page: Int) -> AnyPublisher<[Match], Error> {
        
        let beginAtDescendent: URLQueryItem = .init(name: PSQueryItems.sort, value: "-scheduled_at")
        let opponentsFilled: URLQueryItem = .init(name: PSQueryItems.opponentsFilled, value: "true")
        let page: URLQueryItem = .init(name: PSQueryItems.page, value: String(page))
        let size: URLQueryItem = .init(name: PSQueryItems.size, value: "10")
        let perPage: URLQueryItem = .init(name: PSQueryItems.perPage, value: "10")
        
        let request: PSRequest = .init(
            endpoint: .matches,
            pathComponents: [videogame.value],
            queryParameters: [beginAtDescendent, opponentsFilled, page, size, perPage]
        )
        
        return self.apiService.request(request: request, expecting: Match.self)
            .eraseToAnyPublisher()
    }
}
