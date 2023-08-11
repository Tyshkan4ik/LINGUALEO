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
    
    var delete: ((_ section: Int, _ index: Int) -> ())? { get set }
    func deletePeople()
}

class DetailedViewModel: DetailedViewModelProtocol {
    
    //MARK: - Properties
    
    var updatePlayersModel: ((MainModel) -> ())?
    
    var delete: ((_ section: Int, _ index: Int) -> ())?
    
    private let section: Int
    
    private let index: Int
    
    var playerModel: MainModel
    
    //MARK: - Initializers
    
    init(playersModel: MainModel, section: Int, index: Int) {
        self.playerModel = playersModel
        self.section = section
        self.index = index
    }
    
    //MARK: - Methods
    
    func viewDidLoad() {
        updatePlayersModel?(playerModel)
    }
    
    func deletePeople() {
        delete?(section, index)
    }
}
