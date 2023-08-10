//
//  MainViewModel.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var updatePlayersModel: ((PlayersModel) -> ())? { get set }
    func getPlayerData()
}

class MainViewModel: MainViewModelProtocol {
    
    var updatePlayersModel: ((PlayersModel) -> ())?
    
    func getPlayerData() {
        
    }
}
