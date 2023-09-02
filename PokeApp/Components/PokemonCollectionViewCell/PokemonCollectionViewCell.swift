//
//  PokemonCollectionViewCell.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 1/09/23.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "PokemonCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.0/255.0, green: 16.0/255.0, blue: 11.0/255.0, alpha: 1.0)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        setUpCell()
        addConstraints()
    }
    
    private func setUpCell() {
        contentView.backgroundColor = .label.withAlphaComponent(0.05)
        contentView.layer.cornerRadius = 15
        
        
        contentView.layer.mask = blurredLayerMask()
    }
    
    private func blurredLayerMask() -> CAGradientLayer {
        let maskLayer = CAGradientLayer()
        maskLayer.frame = contentView.bounds
        maskLayer.shadowRadius = 5
        maskLayer.shadowPath = CGPath(roundedRect: contentView.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
        maskLayer.shadowOpacity = 1;
        maskLayer.shadowOffset = CGSize.zero;
        maskLayer.shadowColor = UIColor.white.cgColor
        
        return maskLayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5)
            
        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpCell()
    }
    
    public func configure(with viewModel: PokemonCollectionViewCellViewModel) {
        
        nameLabel.text = viewModel.pokemonName
        
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
                
            case .failure(let failure):
                print(String(describing: failure))
                break
            }
        }
    }
    
}
