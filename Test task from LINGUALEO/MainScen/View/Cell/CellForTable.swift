//
//  CellForTable.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 10.08.2023.
//

import UIKit

final class CellForTable: UITableViewCell {
    
    private enum Constants {
        static let alphaCellFrame: CGFloat = 0.95
        static let cornerRadiusCellFrame: CGFloat = 18
        static let systemNamePeopleSymbol = "person"
        static let fontSize: CGFloat = 20
        static let cellFrameConstant: CGFloat = 10
        static let peopleSymbolWidth: CGFloat = 30
        static let constraintConstant: CGFloat = 20
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - Properties
    private let cellFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.alpha = Constants.alphaCellFrame
        view.layer.cornerRadius = Constants.cornerRadiusCellFrame
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let peopleSymbol: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: Constants.systemNamePeopleSymbol)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let score: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
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
            cellFrame.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellFrameConstant),
            cellFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.cellFrameConstant),
            cellFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.cellFrameConstant),
            cellFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            peopleSymbol.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            peopleSymbol.leadingAnchor.constraint(equalTo: cellFrame.leadingAnchor, constant: Constants.constraintConstant),
            peopleSymbol.widthAnchor.constraint(equalToConstant: Constants.peopleSymbolWidth),
            peopleSymbol.heightAnchor.constraint(equalTo: peopleSymbol.widthAnchor),
            
            name.topAnchor.constraint(equalTo: cellFrame.topAnchor, constant: Constants.constraintConstant),
            name.leadingAnchor.constraint(equalTo: peopleSymbol.trailingAnchor, constant: Constants.constraintConstant),
            name.trailingAnchor.constraint(equalTo: score.leadingAnchor, constant: -Constants.constraintConstant),
            name.bottomAnchor.constraint(equalTo: cellFrame.bottomAnchor, constant: -Constants.constraintConstant),
            
            score.centerYAnchor.constraint(equalTo: name.centerYAnchor),
            score.trailingAnchor.constraint(equalTo: cellFrame.trailingAnchor, constant: -Constants.constraintConstant)
        ])
    }
    
    func setup(model: MainModel.Player) {
        name.text = model.name
        score.text = String(model.score)
    }
}
