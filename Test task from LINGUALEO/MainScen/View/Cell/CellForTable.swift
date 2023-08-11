//
//  CellForTable.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import UIKit

class CellForTable: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - Properties
    
    private let cellFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.alpha = 0.95
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let peopleSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let score: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        setupConstraints()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupSubview() {
        contentView.addSubview(cellFrame)
        cellFrame.addSubview(name)
        cellFrame.addSubview(score)
        cellFrame.addSubview(peopleSymbol)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            peopleSymbol.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            peopleSymbol.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: 20),
            peopleSymbol.widthAnchor.constraint(equalToConstant: 30),
            peopleSymbol.heightAnchor.constraint(equalTo: peopleSymbol.widthAnchor),
            
            name.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: peopleSymbol.trailingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: score.leadingAnchor, constant: -20),
            name.bottomAnchor.constraint(equalTo: cellFrame.bottomAnchor, constant: -20),
            
            score.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            score.trailingAnchor.constraint(equalTo: cellFrame.trailingAnchor, constant: -20)
        ])
    }
    
    func setup(model: MainModel.Player) {
        name.text = model.name
        score.text = String(model.score)
    }
}
