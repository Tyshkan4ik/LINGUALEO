//
//  MainViewController.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private enum Constants {
        static let nameBackgroundImage = "MainLinguaLeo"
        static let alphaBackgroundImage: CGFloat = 0.5
        static let alphaTableView: CGFloat = 0.9
    }
    
    //MARK: - Properties
    private var viewModel: MainViewModelProtocol
    
    private var dataModel = [MainModel]()
    
    private let backgroundImage: UIImageView = {
        let image = UIImage(named: Constants.nameBackgroundImage)
        let imageView = UIImageView(image: image)
        imageView.alpha = Constants.alphaBackgroundImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.alpha = Constants.alphaTableView
        tableView.register(CellForTable.self, forCellReuseIdentifier: CellForTable.identifier)
        tableView.register(ViewForSectionTable.self, forHeaderFooterViewReuseIdentifier: ViewForSectionTable.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Initializers
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindingViewModel()
        
        viewModel.getPlayersData()
        viewModel.viewDidLoad()
    }
    
    //MARK: - Methods
    private func bindingViewModel() {
        viewModel.setupInitial = { [weak self] in
            self?.setupElements()
            self?.setupConstraints()
            self?.setupTable()
        }
        
        viewModel.updatePlayersModel = { [weak self] model in
            self?.dataModel = model
            self?.tableView.reloadData()
        }
    }
    
    private func setupElements() {
        view.addSubview(backgroundImage)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - extension - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModel[section].players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForTable.identifier, for: indexPath) as? CellForTable else {
            return UITableViewCell()
        }
        
        let model = dataModel[indexPath.section].players[indexPath.row]
        cell.setup(model: model)
        return cell
    }
}

//MARK: - extension - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ViewForSectionTable.identifier) as? ViewForSectionTable
        let model = dataModel[section]
        
        view?.setup(model: model.cuntry)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cuntry = dataModel[indexPath.section].cuntry
        let player = dataModel[indexPath.section].players[indexPath.row]
        
        let detailViewModel = DetailedViewModel(
            playersModel: DetailModel(
                cuntry: cuntry,
                name: player.name,
                age: player.age,
                level: player.level,
                score: player.score,
                indexPath: indexPath
            )
        )
        
        let controller = DetailedInformationViewController(detailedViewModel: detailViewModel)
        
        detailViewModel.delete = { [weak self] indexPath in
            guard let self else { return }
            controller.navigationController?.popViewController(animated: true)
            self.dataModel[indexPath.section].players.remove(at: indexPath.row)
            
            if self.dataModel[indexPath.section].players.isEmpty  {
                self.dataModel.remove(at: indexPath.section)
            }
            
            self.tableView.reloadData()
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
