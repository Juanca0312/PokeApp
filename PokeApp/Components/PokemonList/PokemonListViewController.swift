//
//  PokemonListViewController.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import UIKit
import Combine

class PokemonListViewController: UIViewController {
    
    private let pokemonListView = PokemonListView()
    private let viewModel = PokemonListViewModel()
    var anyCancellable: [AnyCancellable] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Poke app"
        
        setGradientBackground()
        setUpView()
        viewModel.fetchPokemons()
        subscription()
    }
    
    private func subscription() {
        viewModel.$pokemonList.sink { data in
            print(data?[0])
            DispatchQueue.main.async {
                self.pokemonListView.collectionView.reloadData()
            }
        }.store(in: &anyCancellable)
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
        return viewModel.pokemonList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .systemBlue
        
        
        return cell
    }
    
    
}
