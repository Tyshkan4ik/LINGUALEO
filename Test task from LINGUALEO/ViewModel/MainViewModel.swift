//
//  MainViewModel.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    /// Обновляем список пользователей во View
    var updatePlayersModel: (([MainModel]) -> ())? { get set }
    /// Получить данные пользователей
    func getPlayersData()
    /// View  загрузилась
    func viewDidLoad()
    /// Начальная настрока View
    var setupInitial: (() -> Void)? { get set }
}

final class MainViewModel: MainViewModelProtocol {
    
    //MARK: - Properties
    private var networkService = NetworkService()
    
    var updatePlayersModel: (([MainModel]) -> ())?
    var setupInitial: (() -> Void)?
    
    //MARK: - Methods
    func viewDidLoad() {
        setupInitial?()
    }
    
    func getPlayersData() {
        networkService.getPlayers { [weak self] result in
            switch result {
            case let .success(model):
                let groupedModel = Dictionary(grouping: model, by: { $0.player.country })
                var model = groupedModel.map { country, players in
                    let players = players.map { player in
                        MainModel.Player(
                            name: player.player.name,
                            age: player.player.age,
                            level: player.playerInfo.level,
                            score: player.playerInfo.score
                        )
                    }.sorted { first, second in
                        first.score > second.score
                    }
                    return MainModel(cuntry: country, players: players)
                }
                model.sort { first, second in
                    first.cuntry < second.cuntry
                }
                self?.updatePlayersModel?(model)
                
            case .failure(.invalidateResponse):
                print("Error invalidateResponse")
            }
        }
    }
}
