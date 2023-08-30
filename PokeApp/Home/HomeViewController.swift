//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import UIKit

final class HomeViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        let vc = PokemonListViewController()
        vc.navigationItem.largeTitleDisplayMode = .automatic
        
        viewControllers = [vc]
        
    }

}
