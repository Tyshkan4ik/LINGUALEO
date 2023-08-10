//
//  MainViewModel.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    var updatePlayersModel: (([String: [PlayersModel]]) -> ())? { get set }
    func getPlayersData()
}

class MainViewModel: MainViewModelProtocol {
    
    
    var playersModel: PlayersModel?
    
    var playersModelArray = [PlayersModel]()
    
    ///словарь с отсартированными игроками внутри стран
    var playersDictionary = [String: [PlayersModel]]() {
        didSet {
            updatePlayersModel?(playersDictionary)
        }
    }
    
    var updatePlayersModel: (([String: [PlayersModel]]) -> ())?
    
    var networkService = NetworkService()
    
    func getPlayersData() {
        networkService.getPlayers { [weak self] result in
            switch result {
            case let .success(models):
                for model in models {
                    self?.playersModelArray.append(PlayersModel(country: model.player.country, name: model.player.name, age: model.player.age, level: model.playerInfo.level, score: model.playerInfo.score))
                }
            case .failure(.invalidateResponse):
                print("Error invalidateResponse")
            }
        }
        playersDictionary = dictionaryFillingAndSorting(models: playersModelArray)
    }
    
    /// заполняем словарь с отсартированными игроками внутри стран
    func dictionaryFillingAndSorting(models: [PlayersModel]) -> [String: [PlayersModel]] {
        var dictionary = [String: [PlayersModel]]()
        for model in models {
            if dictionary[model.country] == nil {
                dictionary[model.country] = [model]
            } else {
                dictionary[model.country]?.append(model)
            }
        }
        let newDictionary = dictionary.mapValues { $0.sorted { $0.score > $1.score } }
        
        return newDictionary
    }
}
