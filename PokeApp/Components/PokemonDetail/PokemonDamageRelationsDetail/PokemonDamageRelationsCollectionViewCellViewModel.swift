//
//  PokemonDamageRelationsCollectionViewCellViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import Foundation
import Combine
final class PokemonDamageRelationsCollectionViewCellViewModel {
    
    private let typeUrl: URL?
    private let typeService: TypeServiceProtocol
    @Published public var typeObservable: TypeResponse?

    
    init(typeUrl: URL?, typeService: TypeServiceProtocol = TypeService()) {
        self.typeUrl = typeUrl
        self.typeService = typeService
        
        fetchData()
    }
    
    public func arraysToAttributedString(_ arrays: [TypeInfo]...) -> NSMutableAttributedString {
        var typesArray : [TypeInfo] = []
        
        for array in arrays {
            typesArray.append(contentsOf: array.map({ $0 }))
        }
        
        let typesString = typesArray.map { $0.name.rawValue }.joined(separator: " / ")
        let attributedText = NSMutableAttributedString(string: typesString)

        for type in typesArray {
            let range = (attributedText.string as NSString).range(of: type.name.rawValue)
            attributedText.addAttribute(.foregroundColor, value: type.name.typeColor, range: range)
        }
        
        return attributedText
    }
    
    private func fetchData() {
        guard let typeUrl = typeUrl else { return }
        guard let typeId = Int(typeUrl.lastPathComponent) else { return }
        
        typeService.getTypeById(id: typeId) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.typeObservable = response
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
