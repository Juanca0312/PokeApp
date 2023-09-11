//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import UIKit
import Combine

class PokemonDetailViewController: UIViewController {
    
    private let pokemonDetailView: PokemonDetailView
    private let viewModel: PokemonDetailViewModel
    var anyCancellable: [AnyCancellable] = []

    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        self.pokemonDetailView = PokemonDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
        viewModel.fetchPokemon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pokemonDetailView)
        title = viewModel.title
        setGradientBackground()
        addConstraints()
        
        pokemonDetailView.collectionView?.dataSource = self
        pokemonDetailView.collectionView?.delegate = self
        
        subscription()
    }
    
    private func subscription() {
        viewModel.$pokemonObservable.sink { [weak self] data in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.viewModel.setUpSections()
                self.pokemonDetailView.collectionView?.reloadData()
                
            }
            
        }.store(in: &anyCancellable)
        
        viewModel.$isLoading.sink {[weak self] isLoading in
            guard let isLoading = isLoading, let self = self else { return }
            DispatchQueue.main.async {
                self.pokemonDetailView.showFirstLoading(isLoading: isLoading)
            }
        }.store(in: &anyCancellable)
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
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            pokemonDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pokemonDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            pokemonDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
}

extension PokemonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .images(let viewModels):
            return viewModels.count
        case .info(let viewModels):
            return viewModels.count
        case .stats(let viewModels):
            return viewModels.count
        case .damageRelations(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //dequeue based on section
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .images(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonImagesCollectionViewCell.cellIdentifier, for: indexPath) as? PokemonImagesCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .info(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonInfoCollectionViewCell.cellIdentifier, for: indexPath) as? PokemonInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .stats(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonStatsCollectionViewCell.cellIdentifier, for: indexPath) as? PokemonStatsCollectionViewCell else {
                fatalError()
            }
            cell.backgroundColor = .systemTeal
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .damageRelations(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonDamageRelationsCollectionViewCell.cellIdentifier, for: indexPath) as? PokemonDamageRelationsCollectionViewCell else {
                fatalError()
            }
            cell.backgroundColor = .systemMint
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
        
    }
    
    
}
