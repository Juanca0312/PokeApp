//
//  Pokemon.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/23.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int // decimeter
    let weight: Int // hectograms
    let stats: [Stat]
    let types: [`Type`]
    
}
