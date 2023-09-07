//
//  Endpoint.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation

public struct Endpoint {
    
    static let baseURL = "https://pokeapi.co/api/v2"
    
    
    public var path: String
    
    public init(path: String) {
        self.path = path
    }
    
    func url(queryItems: [URLQueryItem] = []) -> URL? {
        guard var components = URLComponents(string: Endpoint.baseURL+path) else { return nil }
        components.queryItems = queryItems
        return components.url
    }
}

extension Endpoint {
    
    static public func pokemonEndpoint(id: Int? = nil) -> Endpoint {
        if let id = id {
            return Endpoint(path: "/pokemon/\(id)")
        }
        return Endpoint(path: "/pokemon")
    }
    
}

