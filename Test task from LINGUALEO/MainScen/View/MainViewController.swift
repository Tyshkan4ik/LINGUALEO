//
//  MainViewController.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    var dataModel = [MainModel]()
    
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
    
    private var viewModel: MainViewModelProtocol
    
    //MARK: - Methods
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func bindingViewModel() {
        viewModel.setupInitial = { [weak self] in
            self?.setupElements()
            self?.setupConstraints()
            self?.setupTable()
        }
        
        viewModel.updatePlayersModel = { [weak self] model in
            self?.dataModel = model
            self?.table.reloadData()
        }
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ViewForSectionTable.identifier) as? ViewForSectionTable
        let model = dataModel[section]
        
        view?.setup(model: model.cuntry)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = DetailedViewModel(playersModel: MainModel(cuntry: dataModel[indexPath.section].cuntry, players: [dataModel[indexPath.section].players[indexPath.row]]))
        let controller = DetailedInformationViewController(detailedViewModel: detailViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
