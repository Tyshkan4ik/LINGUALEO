//
//  DetailedViewModel.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 11.08.2023.
//

import Foundation

protocol DetailedViewModelProtocol {
    var updatePlayersModel: ((MainModel) -> ())? { get set }
    var playerModel: MainModel { get set }
    func viewDidLoad()
}

class DetailedViewModel: DetailedViewModelProtocol {
    
    var updatePlayersModel: ((MainModel) -> ())?
    
    
    var playerModel: MainModel
    
    ///словарь с отсартированными игроками внутри стран
    var playersDictionary = [String: [MainModel]]() {
        didSet {
           // updatePlayersModel?(playersDictionary)
        }
    }
    
    
    init(playersModel: MainModel) {
        self.playerModel = playersModel
        
    }
    
    func viewDidLoad() {
        updatePlayersModel?(playerModel)
    }
    
    
}
