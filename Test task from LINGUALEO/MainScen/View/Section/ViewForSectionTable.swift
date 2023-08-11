//
//  ViewForSectionTable.swift
//  Test task from LINGUALEO
//
//  Created by Виталий Троицкий on 11.08.2023.
//

import UIKit

class ViewForSectionTable: UITableViewHeaderFooterView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - Properties
    
    private let sectionFrame: UIView = {
        let view = UIView()
        //view.backgroundColor = .systemBlue
        view.alpha = 0.95
        
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let country: UILabel = {
        let label = UILabel()
        label.text = "HELLO"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubview()
        setupConstraints()
        //backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupSubview() {
        contentView.addSubview(sectionFrame)
        sectionFrame.addSubview(country)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            sectionFrame.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionFrame.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sectionFrame.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sectionFrame.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            country.centerYAnchor.constraint(equalTo: sectionFrame.centerYAnchor),
            country.centerXAnchor.constraint(equalTo: sectionFrame.centerXAnchor)

        ])
    }
    
    func setup(model: String) {
        country.text = model
    }
}

