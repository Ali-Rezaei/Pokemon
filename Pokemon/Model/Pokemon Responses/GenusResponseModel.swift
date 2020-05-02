//
//  GenusResponseModel.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-29.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

struct GenusResponseModel : Codable {
    
    let genus: String
    let language: NamedResponseModel
}
