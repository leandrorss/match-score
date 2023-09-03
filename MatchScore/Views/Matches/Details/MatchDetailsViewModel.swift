//
//  MatchDetailsViewModel.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import Foundation
import Combine

class MatchDetailsViewModel: ObservableObject {
    
    var cancelables = Set<AnyCancellable>()
    
    let service: TeamServiceContract
    
    @Published var teams: [Team] = []
    
    let match: Match
    
    var playersOpponentOne: [Player] {
        guard let opponents = match.opponents, opponents.count >= 1 else {
            return []
        }
        
        let opponentId = opponents[0].opponent.id
        return teams.first(where: { $0.id == opponentId })?.players ?? []
    }
    
    var playersOpponentTwo: [Player] {
        guard let opponents = match.opponents, opponents.count >= 2 else {
            return []
        }
        
        let opponentId = opponents[1].opponent.id
        return teams.first(where: { $0.id == opponentId })?.players ?? []
        
    }
    
    var hasOpponents: Bool {
        playersOpponentOne.count > 0 && playersOpponentTwo.count > 0
    }
    
    init(
        match: Match,
        service: TeamServiceContract = TeamService()
    ) {
        self.service = service
        self.match = match
    }
    
    func loadTeams() {
        
        let teamsId: [Int] = match.opponents?.compactMap({ $0.opponent.id }) ?? []
        
        let publishers: [AnyPublisher<[Team], Error>] = teamsId.map { service.getTeam(videogame: .csgo, id: $0) }
        
        Publishers.MergeMany(publishers)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { teams in
                DispatchQueue.main.async {
                    self.teams.append(teams[0])
                }
            }
            .store(in: &cancelables)
    }
}
