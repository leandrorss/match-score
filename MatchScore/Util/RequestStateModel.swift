//
//  RequestStateModel.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import Foundation

// MARK: - Enum Request States
enum RequestState {
    case none
    case refresh
    case initialFetch
    case additionalItems
}
