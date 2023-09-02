//
//  PokemonListView.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import UIKit

class PokemonListView: UIView {
    

    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        //collectionView.isHidden = true
        //collectionView.alpha = 0 //opacity
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(collectionView)
        //addSubview(spinner)
        addConstraints()

        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsopported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            //spinner.widthAnchor.constraint(equalToConstant: 100),
            //spinner.heightAnchor.constraint(equalToConstant: 100),
            //spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            //spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    
}
