//
//  ResponseModel.Team.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import Foundation

struct Team: Decodable {
    let id: Int
    let name: String
    let players: [Player]
}

extension Team: Identifiable { }

extension Player: Identifiable { }

struct Player: Decodable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let nickname: String
    let imageUrl: String?
    
    var fullName: String {
        guard let firstName = firstName, let lastName = lastName else {
            return nickname
        }
        return "\(firstName) \(lastName)"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname = "name"
        case imageUrl = "image_url"
    }
}
