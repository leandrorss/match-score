//
//  TeamService.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import Foundation
import Combine

protocol TeamServiceContract {
    func getTeam(videogame: PSVideogame, id: Int) -> AnyPublisher<[Team], Error>
}

class TeamService: TeamServiceContract {
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func getTeam(videogame: PSVideogame, id: Int) -> AnyPublisher<[Team], Error> {
        
        let id: URLQueryItem = .init(name: PSQueryItems.filterById, value: String(id))
        let page: URLQueryItem = .init(name: PSQueryItems.page, value: "1")
        let size: URLQueryItem = .init(name: PSQueryItems.size, value: "1")
        let perPage: URLQueryItem = .init(name: PSQueryItems.perPage, value: "1")
        
        let request: PSRequest = .init(
            endpoint: .teams,
            pathComponents: [videogame.value],
            queryParameters: [id, page, size, perPage]
        )
        
        return self.apiService.request(request: request, expecting: Team.self)
            .eraseToAnyPublisher()
    }
}
