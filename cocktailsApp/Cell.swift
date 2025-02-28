//
//  Cell.swift
//  cocktailsApp
//
//  Created by Anna Melekhina on 28.02.2025.
//

import UIKit

final class Cell: UITableViewCell {
    
    private lazy var instrucLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Optima", size: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Optima", size: 24)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Author"
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ingredLabel = UILabel()
    private lazy var containerView = UIView()
    lazy var bookmarkButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(named: "pink1") ?? UIColor.yellow
        containerView.layer.cornerRadius = 15
        contentView.addSubview(containerView)
        
        ingredLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        ingredLabel.textColor = .black
        ingredLabel.adjustsFontSizeToFitWidth = true
        ingredLabel.minimumScaleFactor = 0.7
        ingredLabel.numberOfLines = 7
        ingredLabel.textAlignment = .left
        ingredLabel.font = UIFont(name: "Optima", size: 18)
        containerView.addSubview(ingredLabel)
        
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .systemGray
        containerView.addSubview(bookmarkButton)
        
        
        containerView.addSubview(instrucLabel)
        containerView.addSubview(nameLabel)

        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            bookmarkButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bookmarkButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),

            
            ingredLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            ingredLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            ingredLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            instrucLabel.topAnchor.constraint(equalTo: ingredLabel.bottomAnchor, constant: 10),
            instrucLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            instrucLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            instrucLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    func configure(with cocktail: CocktailModel) {
        ingredLabel.text = cocktail.ingredients
        instrucLabel.text = cocktail.instructions
        nameLabel.text = cocktail.name
    }
}

