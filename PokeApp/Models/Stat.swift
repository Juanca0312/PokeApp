//
//  Stat.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/23.
//

import Foundation

struct Stat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: StatInfo
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

struct StatInfo: Codable {
    let name: String
    let url: String
}
