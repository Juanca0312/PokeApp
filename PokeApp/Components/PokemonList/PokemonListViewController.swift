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
    private var currentOffSet = 0
    private var fetchingNextPage = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PokeApp"
        
        setGradientBackground()
        setUpView()
        viewModel.fetchPokemons()
        subscription()
    }
    
    private func subscription() {
        viewModel.$pokemonListResponse.sink { [weak self] data in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.pokemonListView.collectionView.reloadData()
            }
            
            //did load more data
            self.fetchingNextPage = false
            
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
        return viewModel.pokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.cellIdentifier, for: indexPath) as? PokemonCollectionViewCell else {
            fatalError("Unsoported cell")
        }
        
        guard indexPath.row < viewModel.cellViewModels.count else {
            return cell
        }
        
        cell.configure(with: viewModel.cellViewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: LoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? LoadingCollectionReusableView else {
            fatalError("Unsopported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width, height: width * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard !fetchingNextPage else { return }
        
        if indexPath.row > viewModel.pokemonList.count - 4 {
            fetchingNextPage = true
            currentOffSet += PokemonService.pageLimit
            
            //TODO: remove or edit asyncAfter to simulate loading
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.viewModel.fetchPokemons(offSet: self.currentOffSet)
//
//            }
            self.viewModel.fetchPokemons(offSet: self.currentOffSet)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = PokemonDetailViewModel(pokemon: self.viewModel.pokemonList[indexPath.row])
        let detailVC = PokemonDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
