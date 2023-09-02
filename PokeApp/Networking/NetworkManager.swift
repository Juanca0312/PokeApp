//
//  NetworkManager.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    enum NetworkManagerError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard let url = request.endpoint.url(queryItems: request.queryItems) else { preconditionFailure("Invalid URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkManagerError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
}
