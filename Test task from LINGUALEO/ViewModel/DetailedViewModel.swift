//
//  DetailedViewModel.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 11.08.2023.
//

import Foundation

protocol DetailedViewModelProtocol {
    /// Обновляем данные пользователя
    var updatePlayersModel: ((DetailModel) -> ())? { get set }
    /// Модель пользователей
    var playerModel: DetailModel { get set }
    /// Передаем удаляемого пользователя
    var delete: ((IndexPath) -> ())? { get set }
    
    /// Удаляем пользователя из списка
    func deletePlayer()
    /// Начальная настрока View
    func viewDidLoad()
    /// Начальная настрока View
    var setupInitial: (() -> Void)? { get set }
}

final class DetailedViewModel: DetailedViewModelProtocol {
    
    //MARK: - Properties
    var playerModel: DetailModel
    
    var updatePlayersModel: ((DetailModel) -> ())?
    var delete: ((IndexPath) -> ())?
    var setupInitial: (() -> Void)?
    
    //MARK: - Initializers
    init(playersModel: DetailModel) {
        self.playerModel = playersModel
    }
    
    //MARK: - Methods
    func viewDidLoad() {
        setupInitial?()
        updatePlayersModel?(playerModel)
    }
    
    func deletePlayer() {
        delete?(playerModel.indexPath)
    }
}
