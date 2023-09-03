//
//  DispatchQueueMock.swift
//  MatchScoreTests
//
//  Created by Leandro Rodrigues on 03/09/23.
//
import Foundation

@testable import MatchScore
final class DispatchQueueMock: DispatchQueueContract {

    private var asyncOnMainWorkItems: [() -> Void] = []

    func asyncOnMain(execute work: @escaping @convention(block) () -> Void) {
        asyncOnMainWorkItems.append(work)
    }

    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }

    func executeAsyncOnMainWorkItems() {
        asyncOnMainWorkItems.forEach { $0() }
        asyncOnMainWorkItems.removeAll()
    }
}
