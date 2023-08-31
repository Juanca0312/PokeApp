//
//  Request.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation

/// Represents an API call
public struct Request{
    
    public var endpoint: Endpoint
    public var method: HTTPMethod
    public var queryItems: [URLQueryItem]
    
    public init(endpoint: Endpoint, method: HTTPMethod = .get, queryItems: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.method = method
        self.queryItems = queryItems
    }
    
}

