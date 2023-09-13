//
//  PokemonDamageRelationsDetailCollectionViewCell.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import UIKit
import Combine

class PokemonDamageRelationsCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "PokemonDamageRelationsCollectionViewCell"
    
    var anyCancellable: [AnyCancellable] = []

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray6
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let strongTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray6
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Strong Against"
        return label
    }()
    
    private let strongValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black.withAlphaComponent(0.3)

        return label
    }()
    
    private let weaknessTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray6
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Weakness"

        return label
    }()
    
    private let weaknessValue: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black.withAlphaComponent(0.3)
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setUpView()
        
        setUpConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        contentView.backgroundColor = .tertiaryLabel
        contentView.layer.cornerRadius = 8
        contentView.addSubview(typeLabel)
        contentView.addSubview(strongTitle)
        contentView.addSubview(strongValue)
        contentView.addSubview(weaknessTitle)
        contentView.addSubview(weaknessValue)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            typeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            strongTitle.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 7),
            strongTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            strongTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            strongValue.topAnchor.constraint(equalTo: strongTitle.bottomAnchor),
            strongValue.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            strongValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            weaknessTitle.topAnchor.constraint(equalTo: strongValue.bottomAnchor, constant: 7),
            weaknessTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            weaknessTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            weaknessValue.topAnchor.constraint(equalTo: weaknessTitle.bottomAnchor),
            weaknessValue.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            weaknessValue.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        strongTitle.text = ""
        strongValue.text = ""
        weaknessTitle.text = ""
        weaknessValue.text = ""
    }
    
    public func configure(with viewModel: PokemonDamageRelationsCollectionViewCellViewModel) {
        viewModel.$typeObservable.sink { [weak self] data in
            
            guard let self = self, let data = data else { return }
            
            DispatchQueue.main.async {
                self.typeLabel.text = data.name.capitalized
                self.strongValue.attributedText = viewModel.arraysToAttributedString(
                    data.damageRelations.doubleDamageTo
                )
                self.weaknessValue.attributedText = viewModel.arraysToAttributedString(
                    data.damageRelations.doubleDamageFrom
                )
            }
            
        }.store(in: &anyCancellable)
    }
}
