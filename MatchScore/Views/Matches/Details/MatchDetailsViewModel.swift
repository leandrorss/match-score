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
    
    private let service: TeamServiceContract
    private let mainDispatchQueue: DispatchQueueContract
    
    @Published var teams: [Team] = []
    
    let match: Match
    
    @Published var requestState: RequestState = .none
    
    private func playersForOpponent(at index: Int) -> [Player] {
        guard let opponents = match.opponents, index < opponents.count else {
            return []
        }
        
        let opponentId = opponents[index].opponent.id
        return teams.first { $0.id == opponentId }?.players ?? []
    }

    var playersOpponentOne: [Player] {
        return playersForOpponent(at: 0)
    }

    var playersOpponentTwo: [Player] {
        return playersForOpponent(at: 1)
    }
    
    var hasOpponents: Bool {
        playersOpponentOne.count > 0 && playersOpponentTwo.count > 0
    }
    
    init(
        match: Match,
        service: TeamServiceContract = TeamService(),
        mainDispatchQueue: DispatchQueueContract = DispatchQueue.main
    ) {
        self.service = service
        self.match = match
        self.mainDispatchQueue = mainDispatchQueue
    }
    
    func loadTeams(_ operation: RequestState) {
        
        self.requestState = operation
        
        let teamsId: [Int] = match.opponents?.compactMap({ $0.opponent.id }) ?? []
        
        let publishers: [AnyPublisher<[Team], Error>] = teamsId.map { service.getTeam(videogame: .csgo, id: $0) }
        
        Publishers.MergeMany(publishers)
            .sink { completion in
                switch completion {
                case .finished:
                    self.mainDispatchQueue.async {
                        self.requestState = .none
                    }
                    print("fetch Teams")
                case .failure(let error):
                    self.mainDispatchQueue.async {
                        self.requestState = .none
                    }
                    print(error)
                }
            } receiveValue: { [weak self] teams in
                if !teams.isEmpty {
                    self?.mainDispatchQueue.async {
                        self?.teams.append(teams[0])
                    }
                }
            }
            .store(in: &cancelables)
    }
}
