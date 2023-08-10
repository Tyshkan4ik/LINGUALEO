//
//  MainViewController.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    var playersDictionary = [String: [PlayersModel]]()
    
    private lazy var table: UITableView = {
       let table = UITableView()
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var mainViewModel: MainViewModelProtocol? {
        didSet {
            mainViewModel?.updatePlayersModel = { [weak self] dictionary in
                self?.playersDictionary = dictionary
                self?.table.reloadData()
            }
        }
    }
    
    //MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupElements()
        setupConstraints()
        setupTable()
        
        mainViewModel = MainViewModel()
        mainViewModel?.getPlayersData()
        
    }
    
    private func setupElements() {
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTable() {
        table.delegate = self
        table.dataSource = self
        table.register(CellForTable.self, forCellReuseIdentifier: CellForTable.identifier)
        table.register(ViewForSectionTable.self, forHeaderFooterViewReuseIdentifier: ViewForSectionTable.identifier)
        table.separatorStyle = .none
    }
}

//MARK: - extension - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        playersDictionary.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys: [String] = Array(playersDictionary.keys)
        let key = keys[section]
        return playersDictionary[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForTable.identifier, for: indexPath) as? CellForTable else {
            return UITableViewCell()
        }
        
        let keys: [String] = Array(playersDictionary.keys)
        let key = keys[indexPath.section]
        
        guard let playersArray = playersDictionary[key] else {
            return UITableViewCell()
        }
        
        cell.setup(model: playersArray[indexPath.row])
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let reuseSection = tableView.dequeueReusableHeaderFooterView(withIdentifier: ViewForSectionTable.identifier) as? ViewForSectionTable else {
            return UITableViewHeaderFooterView()
        }
        let keys: [String] = Array(playersDictionary.keys)
       let key = keys[section]
        
        reuseSection.setup(model: key)
               return reuseSection
    }
}
