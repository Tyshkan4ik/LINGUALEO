//
//  DetailedInformationViewController.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 11.08.2023.
//

import UIKit

class DetailedInformationViewController: UIViewController {
    
    //MARK: - Properties
    
    private let backgroundImage: UIImageView = {
        let image = UIImage(named: "linguaLeo2")
        let imageView = UIImageView(image: image)
        imageView.alpha = 0.8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "Имя: Стасик"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let age: UILabel = {
        let label = UILabel()
        label.text = "Возраст: 30 лет"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let country: UILabel = {
        let label = UILabel()
        label.text = "Город: Санкт-Петербург"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lavel: UILabel = {
        let label = UILabel()
        label.text = "Уровень: 99"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let score: UILabel = {
        let label = UILabel()
        label.text = "Счет: 9999"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buttonDelete: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить пользователя", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        setupConstraints()
        title = "Детальная информация"
    }
    
    private func setupElements() {
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(name)
        backgroundImage.addSubview(age)
        backgroundImage.addSubview(country)
        
        backgroundImage.addSubview(buttonDelete)
        backgroundImage.addSubview(score)
        backgroundImage.addSubview(lavel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            name.topAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.topAnchor),
            name.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            age.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            age.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            country.topAnchor.constraint(equalTo: age.bottomAnchor, constant: 20),
            country.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            
            buttonDelete.bottomAnchor.constraint(equalTo: backgroundImage.safeAreaLayoutGuide.bottomAnchor),
            buttonDelete.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            score.bottomAnchor.constraint(equalTo: buttonDelete.topAnchor, constant: -20),
            score.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            
            lavel.bottomAnchor.constraint(equalTo: score.topAnchor, constant: -20),
            lavel.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
        ])
    }
    
    
}
