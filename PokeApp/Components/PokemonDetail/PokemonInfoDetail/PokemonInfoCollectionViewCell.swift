//
//  PokemonInfoCollectionViewCell.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import UIKit

class PokemonInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PokemonInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: PokemonInfoCollectionViewCellViewModel) {
        
    }
}
