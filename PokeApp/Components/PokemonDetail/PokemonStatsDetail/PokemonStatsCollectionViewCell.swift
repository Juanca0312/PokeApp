//
//  PokemonStatsDetailCollectionViewCell.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import UIKit

class PokemonStatsCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PokemonStatsCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray6
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .quaternaryLabel
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        setUpConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    public func configure(with viewModel: PokemonStatsCollectionViewCellViewModel) {
        titleLabel.text = viewModel.label.replacingOccurrences(of: "-", with: " ")
        valueLabel.text = viewModel.value
    }
}
