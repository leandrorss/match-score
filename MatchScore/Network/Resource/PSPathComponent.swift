//
//  PathComponents.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

enum PSVideogame: String {
    case csgo
    
    var value: String {
        switch self {
        case .csgo:
            return "csgo"
        }
    }
}
