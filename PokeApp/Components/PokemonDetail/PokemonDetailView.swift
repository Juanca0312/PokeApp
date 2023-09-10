//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import UIKit

class PokemonDetailView: UIView {
    
    public var collectionView: UICollectionView?
    private let viewModel: PokemonDetailViewModel
    
    init(frame: CGRect, viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        self.collectionView?.backgroundColor = .clear
        addSubview(collectionView)
        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
        
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSectionFor(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PokemonImagesCollectionViewCell.self, forCellWithReuseIdentifier: PokemonImagesCollectionViewCell.cellIdentifier)
        collectionView.register(PokemonInfoCollectionViewCell.self, forCellWithReuseIdentifier: PokemonInfoCollectionViewCell.cellIdentifier)
        collectionView.register(PokemonStatsCollectionViewCell.self, forCellWithReuseIdentifier: PokemonStatsCollectionViewCell.cellIdentifier)
        collectionView.register(PokemonDamageRelationsCollectionViewCell.self, forCellWithReuseIdentifier: PokemonDamageRelationsCollectionViewCell.cellIdentifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return collectionView
        
        
    }
    
    private func createSectionFor(for sectionIndex: Int) -> NSCollectionLayoutSection  {
        
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case .images:
            return createImagesSectionLayout()
        case .info:
            return createInfoSectionLayout()
        case .stats:
            return createStatsSectionLayout()
        case .damageRelations:
            return createDamageRelationSectionLayout()
        }
        
        
        
    }
    
    
}

// MARK: - Layouts for Sections

extension PokemonDetailView {
    private func createImagesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 10,
                                                     bottom: 10,
                                                     trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.65), heightDimension: .fractionalHeight(0.4)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        
        return section
    }
    
    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 10,
                                                     bottom: 10,
                                                     trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item, item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        return section
    }
    
    
    private func createStatsSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item, item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        return section
    }
    
    
    private func createDamageRelationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 20,
                                                     bottom: 10,
                                                     trailing: 20)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .absolute(300)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        
        return section
    }
}
