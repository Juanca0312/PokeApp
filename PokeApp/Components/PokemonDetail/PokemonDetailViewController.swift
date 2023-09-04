//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let pokemonDetailView = PokemonDetailView()
    private let viewModel: PokemonDetailViewModel

    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(pokemonDetailView)
        title = viewModel.title

    }
    

}
