//
//  ListMatchesViewModelTests.swift
//  MatchScoreTests
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import XCTest
@testable import MatchScore
final class ListMatchesViewModelTests: XCTestCase {

    var sut: ListMatchesViewModel!
    var mockMatchService: MockMatchService!
    var dispatchQueueMock: DispatchQueueMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockMatchService = MockMatchService()
        dispatchQueueMock = DispatchQueueMock()
        sut = ListMatchesViewModel(matchService: mockMatchService, mainDispatchQueue: dispatchQueueMock)
    }

    override func tearDownWithError() throws {
        mockMatchService = nil
        sut = nil
        dispatchQueueMock = nil
        try super.tearDownWithError()
    }

    func test_should_fetch_new_matches_when_trigger_loadData_with_operation_initial_data() throws {
        
        let match1 = makeMatch(id: 1)
        let match2 = makeMatch(id: 2)
        
        let expectedMatches = [match1, match2]
        
        mockMatchService.items = expectedMatches
        
        sut.loadData(.initialFetch)
        
        XCTAssertEqual(sut.matches.count, 2)
        XCTAssertEqual(mockMatchService.listMatchesCalledCount, 1)
        XCTAssertEqual(sut.matches[0], match1)
        XCTAssertFalse(sut.noMatchesFound)
    }
    
    func test_should_set_no_matches_found_to_true_when_no_matches_were_found() throws {
    
        mockMatchService.items = []
        
        sut.loadData(.initialFetch)
        
        XCTAssertEqual(sut.matches.count, 0)
        XCTAssertEqual(mockMatchService.listMatchesCalledCount, 1)
        XCTAssertTrue(sut.noMatchesFound)
    }
    
    func test_last_match_should_be_set_when_matches_is_assigned() throws {
        let match1 = makeMatch(id: 1)
        let match2 = makeMatch(id: 2)
        let match3 = makeMatch(id: 3)
        
        sut.matches = [match1, match2, match3]
        
        XCTAssertEqual(sut.lastMatch, match3)
    }
    
    func test_should_add_aditional_items_when_load_data_is_trigged_with_operation_additional_items() throws {
        let match1 = makeMatch(id: 1)
        
        let match2 = makeMatch(id: 2)
        let match3 = makeMatch(id: 3)
        
        let expectedMatches = [match2, match3]
        
        sut.matches = [match1]
        
        mockMatchService.items = expectedMatches
        
        sut.loadData(.additionalItems)
        
        XCTAssertEqual(sut.matches.count, 3)
        XCTAssertEqual(mockMatchService.listMatchesCalledCount, 1)
        XCTAssertEqual(sut.matches[0], match1)
        XCTAssertFalse(sut.noMatchesFound)
        XCTAssertEqual(sut.currentPage, 2)
    }
}

extension ListMatchesViewModelTests {
    func makeMatch(id: Int) -> Match {
        return Match(
            id: id,
            beginAt: "2023-04-10T17:00:00Z",
            scheduledAt: "2023-04-10T17:00:00Z",
            games: [],
            league: .init(id: 1, imageUrl: "", name: "League \(id)"),
            serie: .init(id: 1, fullName: "Serie \(id)"),
            opponents: nil
        )
    }
    
}
