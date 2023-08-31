//
//  Endpoint.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation

public struct Endpoint {
    
    private struct K {
        static let baseURL = "https://pokeapi.co/api/v2"
    }
    
    public var path: String
    
    public init(path: String) {
        self.path = path
    }
    
    func url(queryItems: [URLQueryItem] = []) -> URL? {
        guard var components = URLComponents(string: K.baseURL+path) else { return nil }
        components.queryItems = queryItems
        return components.url
    }
}

extension Endpoint {
    
    static public var pokemon: Endpoint {
        Endpoint(path: "/pokemon")
    }
    
}

