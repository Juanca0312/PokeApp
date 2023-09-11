//
//  PokemonInfoCollectionViewCell.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import UIKit

class PokemonInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PokemonInfoCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray6
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.text = "weight"
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "electric / water"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        backgroundColor = .quaternaryLabel
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: PokemonInfoCollectionViewCellViewModel) {
        
    }
}
