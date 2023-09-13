//
//  PokemonDamageRelationsCollectionViewCellViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import Foundation
final class PokemonDamageRelationsCollectionViewCellViewModel {
    
    private let typeUrl: URL?
    private let typeService: TypeServiceProtocol

    
    init(typeUrl: URL?, typeService: TypeServiceProtocol = TypeService()) {
        self.typeUrl = typeUrl
        self.typeService = typeService
        
        fetchData()
    }
    
    private func fetchData() {
        guard let typeUrl = typeUrl else { return }
        guard let typeId = Int(typeUrl.lastPathComponent) else { return }
        
        typeService.getTypeById(id: typeId) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
