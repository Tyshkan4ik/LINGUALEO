//
//  MainModel.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import Foundation

struct MainModel {
    let cuntry: String
    var players: [Player]
    
    struct Player {
        let name: String
        let age: Int
        let level: Int
        let score: Int
    }
}
