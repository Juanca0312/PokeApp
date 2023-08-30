//
//  PokemonListViewController.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let pokemonListView = PokemonListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Poke app"
        
        setGradientBackground()
        setUpView()
    }
    
    private func setUpView() {
        
        self.view.addSubview(pokemonListView)
        pokemonListView.collectionView.dataSource = self
        pokemonListView.collectionView.delegate = self
        
        
        NSLayoutConstraint.activate([
            pokemonListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pokemonListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 156.0/255.0, green: 102.0/255.0, blue: 215.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 94.0/255.0, green: 159.0/255.0, blue: 215.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
}


extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .systemBlue
        
        return cell
    }
    
    
}
