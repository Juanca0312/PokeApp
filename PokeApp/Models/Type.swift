//
//  Type.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/23.
//

import UIKit

struct `Type`: Codable {
    let slot: Int
    let type: TypeInfo
}

struct TypeResponse: Codable {
    let damageRelations: DamageRelations
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
        case name = "name"
    }
}

struct DamageRelations: Codable {
    let doubleDamageFrom, doubleDamageTo, halfDamageFrom, halfDamageTo, noDamageFrom, noDamageTo: [TypeInfo]

    enum CodingKeys: String, CodingKey {
        case doubleDamageFrom = "double_damage_from"
        case doubleDamageTo = "double_damage_to"
        case halfDamageFrom = "half_damage_from"
        case halfDamageTo = "half_damage_to"
        case noDamageFrom = "no_damage_from"
        case noDamageTo = "no_damage_to"
    }
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
    
    var typeColor: UIColor {
        switch self {
        case .normal:
            return UIColor(red: 168/255, green: 168/255, blue: 120/255, alpha: 1.0)
        case .fighting:
            return UIColor(red: 192/255, green: 48/255, blue: 40/255, alpha: 1.0)
        case .flying:
            return .systemMint
        case .poison:
            return UIColor(red: 160/255, green: 64/255, blue: 160/255, alpha: 1.0)
        case .ground:
            return UIColor(red: 224/255, green: 192/255, blue: 104/255, alpha: 1.0)
        case .rock:
            return UIColor(red: 184/255, green: 160/255, blue: 56/255, alpha: 1.0)
        case .bug:
            return UIColor(red: 168/255, green: 184/255, blue: 32/255, alpha: 1.0)
        case .ghost:
            return UIColor(red: 112/255, green: 88/255, blue: 152/255, alpha: 1.0)
        case .steel:
            return UIColor(red: 184/255, green: 184/255, blue: 208/255, alpha: 1.0)
        case .fire:
            return UIColor(red: 240/255, green: 128/255, blue: 48/255, alpha: 1.0)
        case .water:
            return .systemBlue
        case .grass:
            return UIColor(red: 120/255, green: 200/255, blue: 80/255, alpha: 1.0)
        case .electric:
            return UIColor(red: 248/255, green: 208/255, blue: 48/255, alpha: 1.0)
        case .psychic:
            return UIColor(red: 248/255, green: 88/255, blue: 136/255, alpha: 1.0)
        case .ice:
            return UIColor(red: 152/255, green: 216/255, blue: 216/255, alpha: 1.0)
        case .dragon:
            return UIColor(red: 112/255, green: 56/255, blue: 248/255, alpha: 1.0)
        case .dark:
            return UIColor(red: 112/255, green: 88/255, blue: 72/255, alpha: 1.0)
        case .fairy:
            return UIColor(red: 238/255, green: 153/255, blue: 172/255, alpha: 1.0)
        case .unknown:
            return UIColor.gray
        case .shadow:
            return UIColor.black
        }
    }
}
