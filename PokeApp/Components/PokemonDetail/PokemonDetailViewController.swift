//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let pokemonDetailView: PokemonDetailView
    private let viewModel: PokemonDetailViewModel
    
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
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 6
        case 3:
            return 2
        default:
            return 1
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    
}
