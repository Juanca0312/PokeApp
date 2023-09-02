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
        title = "PokeApp"
        
        setGradientBackground()
        setUpView()
        viewModel.fetchPokemons()
        subscription()
    }
    
    private func subscription() {
        viewModel.$pokemonList.sink { data in
            
            DispatchQueue.main.async {
                self.pokemonListView.collectionView.reloadData()
            }
        }.store(in: &anyCancellable)
        
        viewModel.$isLoading.sink { [weak self] isLoading in
            guard let isLoading = isLoading, let self = self else { return }
            
            DispatchQueue.main.async {
                self.pokemonListView.showFirstLoading(isLoading: isLoading)
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


extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemonList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pokemon = viewModel.pokemonList?[indexPath.row] , let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.cellIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
            fatalError("Unsoported cell")
        }
        
        //TODO: Persist cell view models on array
        let vm = PokemonCollectionViewCellViewModel(pokemonName: pokemon.name, pokemonImageUrl: pokemon.pokemonUrl)
        cell.configure(with: vm)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.4)
    }
    
    
}
