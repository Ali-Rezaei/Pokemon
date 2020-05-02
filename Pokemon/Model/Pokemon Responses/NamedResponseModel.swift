//
//  NamedResponseModel.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-29.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

struct NamedResponseModel: Codable {
    
    let name: String
    let url: String
}

extension Array where Element == NamedResponseModel {
    
    func asDomainModel() -> [Pokemon] {
        var ids = [Int]()
        var i = 0
        while (i < 20) {
            let id = Int.random(in: 1...151)
            if(!ids.contains(id)) {
                ids.append(id)
                i+=1
            }
        }
        ids.sort()
        
        var pokemons = [Pokemon]()
        for index in ids {
            let namedResponseModel = self[index-1]
            if let range = namedResponseModel.url.range(of: "pokemon/") {
                let id = Int(namedResponseModel.url[range.upperBound...].dropLast())
                pokemons.append(Pokemon(id: id!, name: namedResponseModel.name.capitalizingFirstLetter()))
            }
        }
        return pokemons
    }
}
