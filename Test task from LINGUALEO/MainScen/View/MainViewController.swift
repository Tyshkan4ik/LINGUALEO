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
    
    private let backgroundImage: UIImageView = {
        let image = UIImage(named: "MainLinguaLeo")
        let imageView = UIImageView(image: image)
        imageView.alpha = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var table: UITableView = {
       let table = UITableView()
        table.backgroundColor = .clear
        table.alpha = 0.9
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

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
        view.addSubview(backgroundImage)
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailedInformationViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
