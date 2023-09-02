//
//  LoadingCollectionReusableView.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 1/09/23.
//

import UIKit

class LoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "LoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(spinner)
        addContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsopported")
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
