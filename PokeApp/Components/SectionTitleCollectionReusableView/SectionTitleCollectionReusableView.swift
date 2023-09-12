//
//  SectionTitleCollectionReusableView.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 11/09/23.
//

import UIKit

class SectionTitleCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "SectionTitleCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
            //titleLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    public func setTitle(title: String) {
        titleLabel.text = title
    }
    

        
}
