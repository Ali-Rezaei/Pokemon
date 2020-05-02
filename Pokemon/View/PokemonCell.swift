//
//  PokemonCellTableViewCell.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-05-01.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setPokemon(pokemon : Pokemon) {
        idLabel.text = "#\(pokemon.id)"
        nameLabel.text = pokemon.name
    }
}
