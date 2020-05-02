//
//  PokemonSpritesModel.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-29.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

struct PokemonSpritesModel : Codable {
    
    let urlFront: String
    let urlBack: String
    
    enum CodingKeys: String, CodingKey {
        case urlFront = "front_default"
        case urlBack = "back_default"
    }
}
