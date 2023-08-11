//
//  PlayersModelResponce.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import Foundation

typealias PlayersModelResponse = [PlayersModelResponseModel]

struct PlayersModelResponseModel: Codable {
    let player: Player
    let playerInfo: PlayerInfo

    enum CodingKeys: String, CodingKey {
        case player
        case playerInfo = "player_info"
    }
    
    struct Player: Codable {
        let name: String
        let country: String
        let age: Int
    }

    struct PlayerInfo: Codable {
        let level: Int
        let score: Int
    }
}
