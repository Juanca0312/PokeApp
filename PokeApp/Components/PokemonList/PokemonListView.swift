//
//  PokemonListView.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import UIKit

class PokemonListView: UIView {
    
    private let spinner: UIImageView = {
        let pokeball = UIImageView()
        pokeball.contentMode = .scaleAspectFit
        pokeball.clipsToBounds = true
        pokeball.translatesAutoresizingMaskIntoConstraints = false
        pokeball.image = UIImage(named: "Pokeball")
        pokeball.rotate()
        return pokeball
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.cellIdentifier)
        collectionView.register(LoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingCollectionReusableView.identifier)
        
        return collectionView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(collectionView)
        addSubview(spinner)
        addConstraints()

        spinner.startAnimating()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsopported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    // MARK: - First loading function
    public func showFirstLoading(isLoading: Bool) {
        if isLoading {
            collectionView.isHidden = true
            collectionView.alpha = 0
            
        } else {
            //TODO: remove or edit asyncAfter to simulate loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                self.collectionView.isHidden = false
                UIView.animate(withDuration: 1) {
                    self.spinner.alpha = 0
                    self.collectionView.alpha = 1
                }
                
            }

        }
    }
    
    
    
}
