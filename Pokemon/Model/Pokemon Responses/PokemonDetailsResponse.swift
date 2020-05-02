//
//  PokemonDetailsResponse.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-29.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

struct PokemonDetailsResponse : Codable {
    
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let species: NamedResponseModel
    let types: [PokemonTypeModel]
    let sprites: PokemonSpritesModel
}
