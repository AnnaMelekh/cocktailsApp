//
//  CategoryCell.swift
//  cocktailsApp
//
//  Created by Anna Melekhina on 01.03.2025.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    
    private lazy var roundedView: RoundedView = {
        let view = RoundedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor.black
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Ingredient) {
        iconView.image = category.image
        titleLabel.text = category.rawValue
    }
}

// MARK: - Private Methods
private extension CategoryCell {
    func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(roundedView)
        roundedView.addSubview(iconView)
        roundedView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            roundedView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            roundedView.widthAnchor.constraint(equalToConstant: 140),
            roundedView.heightAnchor.constraint(equalToConstant: 140),
            
            iconView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            iconView.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 60),
            iconView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -4)
            
        ])
    }
}


final class RoundedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - Private Methods
private extension RoundedView {
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.borderColor = UIColor(named: "pink1")?.cgColor
        layer.borderWidth = 1
    }
}
