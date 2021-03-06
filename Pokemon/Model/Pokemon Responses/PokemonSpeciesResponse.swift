//
//  PokemonSpeciesResponse.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-29.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

struct PokemonSpeciesResponse : Codable {
    
    let id: Int
    let name: String
    let genera: [GenusResponseModel]
}
