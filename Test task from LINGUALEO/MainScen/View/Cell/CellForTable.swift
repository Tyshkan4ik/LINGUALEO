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
        //backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupSubview() {
        contentView.addSubview(name)
        contentView.addSubview(score)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: score.leadingAnchor, constant: -20),
            name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            score.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            score.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func setup(model: String) {
        name.text = model
        score.text = model
    }
}
