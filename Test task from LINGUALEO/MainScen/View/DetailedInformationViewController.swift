//
//  DetailedInformationViewController.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 11.08.2023.
//

import UIKit

final class DetailedInformationViewController: UIViewController {
    
    private enum Constants {
        static let nameBackgroundImage = "linguaLeo2"
        static let alphaContainerView: CGFloat = 0.8
        static let fontSize: CGFloat = 27
        static let borderWidthButton: CGFloat = 3
        static let cornerRadiusButton: CGFloat = 10
        static let titleButton = "Удалить пользователя"
        static let navigationBarTitle = "Детальная информация"
        static let nameString = "Имя:"
        static let ageString = "Возраст:"
        static let countryString = "Страна:"
        static let lavelString = "Уровень:"
        static let scoreString = "Очки:"
        static let nameLabelTopConstant: CGFloat = 25
        static let topAndBottomConstant: CGFloat = 20
        static let buttonDeleteConstant: CGFloat = 50
    }
    
    //MARK: - Properties
    private var detailedViewModel: DetailedViewModelProtocol?
    
    private let backgroundImage: UIImageView = {
        let image = UIImage(named: Constants.nameBackgroundImage)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = Constants.alphaContainerView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lavelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonDelete: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.titleButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.borderWidth = Constants.borderWidthButton
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = Constants.cornerRadiusButton
        button.addTarget(self, action: #selector(deletePeople), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Initializers
    init(detailedViewModel: DetailedViewModelProtocol) {
        self.detailedViewModel = detailedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bindingViewModel()
        detailedViewModel?.viewDidLoad()
        
    }
    
    //MARK: - Methods
    private func bindingViewModel() {
        detailedViewModel?.setupInitial = { [weak self] in
            self?.setupElements()
            self?.setupConstraints()
        }
        
        detailedViewModel?.updatePlayersModel = { [weak self] model in
            self?.nameLabel.text = "\(Constants.nameString) \(model.name)"
            self?.ageLabel.text = "\(Constants.ageString) \(model.age)"
            self?.countryLabel.text = "\(Constants.countryString) \(model.cuntry)"
            self?.lavelLabel.text = "\(Constants.lavelString) \(model.level)"
            self?.scoreLabel.text = "\(Constants.scoreString) \(model.score)"
        }
    }
    
    private func setupElements() {
        view.addSubview(backgroundImage)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(ageLabel)
        containerView.addSubview(countryLabel)
        
        containerView.addSubview(buttonDelete)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(lavelLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor, constant: Constants.nameLabelTopConstant),
            nameLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.topAndBottomConstant),
            ageLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            countryLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: Constants.topAndBottomConstant),
            countryLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            buttonDelete.bottomAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.bottomAnchor),
            buttonDelete.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: Constants.buttonDeleteConstant),
            buttonDelete.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -Constants.buttonDeleteConstant),
            buttonDelete.heightAnchor.constraint(equalToConstant: Constants.buttonDeleteConstant),
            
            scoreLabel.bottomAnchor.constraint(equalTo: buttonDelete.topAnchor, constant: -Constants.topAndBottomConstant),
            scoreLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            lavelLabel.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: -Constants.topAndBottomConstant),
            lavelLabel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
        ])
    }
    
    private func setupNavigationBar() {
        title = Constants.navigationBarTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    @objc
    private func deletePeople() {
        detailedViewModel?.deletePlayer()
    }
}
