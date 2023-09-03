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
    private let mainDispatchQueue: DispatchQueueContract
    private var cancelables = Set<AnyCancellable>()
    
    @Published var requestState: RequestState = .none
    
    var currentPage: Int = 1
    @Published var matches: [Match] = []
    
    var lastMatch: Match {
        return matches[matches.count - 1]
    }
    
    var noMatchesFound: Bool {
        matches.isEmpty
    }
    
    init(
        matchService: MatchServiceContract = MatchService(),
        mainDispatchQueue: DispatchQueueContract = DispatchQueue.main
    ) {
        self.matchService = matchService
        self.mainDispatchQueue = mainDispatchQueue
    }
    
    func onAppear() {
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
                    self.mainDispatchQueue.async {
                        self.requestState = .none
                    }
                    print("fetchMatches finished")
                case .failure(let error):
                    self.mainDispatchQueue.async {
                        self.requestState = .none
                    }
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] fetchedMatches in
                self?.mainDispatchQueue.async {
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
