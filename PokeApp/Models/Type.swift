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
    let name: TypeName
    let url: String
}

enum TypeName: String, Codable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case `unknown`
    case shadow
}
