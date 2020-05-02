//
//  PokemonListResponse.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-29.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

struct PokemonListResponse : Codable {
    
    let count: Int
    let next: String
    let previous: String?
    let results: [NamedResponseModel]
}
