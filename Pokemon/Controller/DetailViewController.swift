//
//  DetailViewController.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-30.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        
        nameLabel.text = "#\(pokemon.id)\t \(pokemon.name)"
        
        let group = DispatchGroup()
        
        group.enter()
        PokemonClient.getPokemonDetails(id: pokemon.id) { pokemonDetails, error in
            if let path = pokemonDetails?.sprites.urlFront {
                PokemonClient.downloadImage(path: path) { data, error in
                    self.frontImage.image = Helper.getImage(data: data)
                }
            }
            if let path = pokemonDetails?.sprites.urlBack {
                PokemonClient.downloadImage(path: path) { data, error in
                    self.backImage.image = Helper.getImage(data: data)
                }
            }
            
            self.heightLabel.attributedText = Helper.getAttributedString(boldText: "Height:", myString: "\t \(String(pokemonDetails!.height)) decimetres")
            self.weightLabel.attributedText = Helper.getAttributedString(boldText: "Weight:", myString: "\t \(String(pokemonDetails!.weight)) hectograms")
            self.typeLabel.attributedText = Helper.getAttributedString(boldText: "Type:", myString: "\t \(pokemonDetails?.types.map { $0.type.name.capitalizingFirstLetter() }.joined(separator: ", ") ?? "")")
            group.leave()
        }
        
        group.enter()
        PokemonClient.getPokemonSpecies(id: pokemon.id) { species, error in
            if let genus = species?.genera.filter({ $0.language.name == "en"}).map({ $0.genus })[0] {
                
                self.speciesLabel.attributedText = Helper.getAttributedString(boldText: "Species:", myString: "\t \(genus)")
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.contentView.isHidden = false
            self.indicator.stopAnimating()
        }
    }
}
