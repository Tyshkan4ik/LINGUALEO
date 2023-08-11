//
//  DetailedInformationViewController.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 11.08.2023.
//

import UIKit

class DetailedInformationViewController: UIViewController {
    
    //MARK: - Properties
    
    private var detailedViewModel: DetailedViewModelProtocol?
    
    var completionDelete: ((_ section: Int, _ index: Int) -> Void)?
    
    private var detailedPlayer: MainModel?
    
    private let backgroundImage: UIImageView = {
        let image = UIImage(named: "linguaLeo2")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let viewFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let age: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let country: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lavel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let score: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonDelete: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить пользователя", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(deletePeople), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Methods
    
    init(detailedViewModel: DetailedViewModelProtocol) {
        self.detailedViewModel = detailedViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        setupConstraints()
        title = "Детальная информация"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        bindingViewModel()
        detailedViewModel?.viewDidLoad()
        
    }
    
    private func bindingViewModel() {
        detailedViewModel?.updatePlayersModel = { [weak self] model in
            self?.name.text = "Имя: \(model.players.first?.name ?? "")"
            self?.age.text = "Возраст: \(model.players.first?.age ?? 0)"
            self?.country.text = "Город: \(model.cuntry)"
            self?.lavel.text = "Уровень: \(model.players.first?.level ?? 0)"
            self?.score.text = "Счет: \(model.players.first?.score ?? 0)"
        }
    }
    
    private func setupElements() {
        view.addSubview(backgroundImage)
        view.addSubview(viewFrame)
        viewFrame.addSubview(name)
        viewFrame.addSubview(age)
        viewFrame.addSubview(country)
        
        viewFrame.addSubview(buttonDelete)
        viewFrame.addSubview(score)
        viewFrame.addSubview(lavel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewFrame.topAnchor.constraint(equalTo: view.topAnchor),
            viewFrame.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewFrame.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewFrame.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            name.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor, constant: 25),
            name.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            age.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            age.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            country.topAnchor.constraint(equalTo: age.bottomAnchor, constant: 20),
            country.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            buttonDelete.bottomAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.bottomAnchor),
            buttonDelete.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 50),
            buttonDelete.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -50),
            buttonDelete.heightAnchor.constraint(equalToConstant: 50),
            
            score.bottomAnchor.constraint(equalTo: buttonDelete.topAnchor, constant: -20),
            score.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            lavel.bottomAnchor.constraint(equalTo: score.topAnchor, constant: -20),
            lavel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
        ])
    }
    
    @objc
    private func deletePeople() {
        var sectionsDelete: Int = 0
        var indexDelete: Int = 0
        detailedViewModel?.delete = { section, index in
            sectionsDelete = section
            indexDelete = index
        }
        detailedViewModel?.deletePeople()
        
        completionDelete?(sectionsDelete, indexDelete)
        
        navigationController?.popViewController(animated: true)
    }
}
