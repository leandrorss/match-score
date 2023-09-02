//
//  ListMatchesViewModel.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation
import Combine

class ListMatchesViewModel: ObservableObject {
    
    private let matchService: MatchServiceContract
    private var cancelables = Set<AnyCancellable>()
    
    @Published var requestState: RequestState = .none
    
    var currentPage: Int = 1
    @Published var matches: [Match] = []
    
    var lastMatch: Match {
        return matches[matches.count - 1]
    }
    
    init(matchService: MatchServiceContract = MatchService()) {
        self.matchService = matchService
        loadData(.initialFetch)
    }
    
    func loadData(_ operation: RequestState) {
        
        guard requestState == .none else {
            return
        }
        
        self.requestState = operation
        
        if requestState == .additionalItems {
            updateRequestPage()
        }
        
        self.matchService.listMatches(videogame: .csgo, page: currentPage)
            .sink { completion in
                switch completion {
                case .finished:
                    DispatchQueue.main.async {
                        self.requestState = .none
                    }
                    print("fetchMatches finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] fetchedMatches in
                DispatchQueue.main.async {
                    switch self?.requestState {
                    case .initialFetch, .refresh:
                        self?.matches = fetchedMatches
                    case .additionalItems:
                        self?.matches.append(contentsOf: fetchedMatches)
                    default:
                        break
                    }
                }
            }
            .store(in: &cancelables)
    }
}

// MARK: - Enum Request States
extension ListMatchesViewModel {
    enum RequestState {
        case none
        case refresh
        case initialFetch
        case additionalItems
    }
}

// MARK: - Private function
extension ListMatchesViewModel {
    private func updateRequestPage() {
        currentPage = currentPage + 1
    }
}
