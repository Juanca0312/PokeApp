//
//  TypeService.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 13/09/23.
//

import Foundation


protocol TypeServiceProtocol {
    
    func getTypeById(id: Int, completion: @escaping (Result<TypeResponse, Error>) -> Void)
}

struct TypeService: TypeServiceProtocol {
    
    private var networkManager: NetworkManager = NetworkManager.shared
    
    func getTypeById(id: Int, completion: @escaping (Result<TypeResponse, Error>) -> Void) {
        
        let request = Request(endpoint: .typeEndpoint(id: id))
        
        networkManager.execute(request, expecting: TypeResponse.self, completion: completion)
    }
    
    
}
