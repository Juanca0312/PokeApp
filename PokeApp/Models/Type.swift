//
//  Type.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/23.
//

import Foundation

struct `Type`: Codable {
    let slot: Int
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
    let url: String
}
