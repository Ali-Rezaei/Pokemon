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
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        
        group.enter()
        PokemonClient.getPokemonDetails(id: pokemon.id) { pokemonDetails, error in
            if let path = pokemonDetails?.sprites.urlFront {
                PokemonClient.downloadImage(path: path) { data, error in
                    guard let data = data else {
                        return
                    }
                    let image = UIImage(data: data)
                    self.frontImage.image = image
                }
            }
            if let path = pokemonDetails?.sprites.urlBack {
                PokemonClient.downloadImage(path: path) { data, error in
                    guard let data = data else {
                        return
                    }
                    let image = UIImage(data: data)
                    self.backImage.image = image
                }
            }
            
            let boldHeightText = "Height:"
            let attributedHeightString = NSMutableAttributedString(string:boldHeightText, attributes:attrs)
            let heightString = NSMutableAttributedString(string:"\t \(String(pokemonDetails!.height)) decimetres")
            attributedHeightString.append(heightString)
            self.heightLabel.attributedText = attributedHeightString
            
            
            let boldWeightText = "Weight:"
            let attributedWeightString = NSMutableAttributedString(string:boldWeightText, attributes:attrs)
            let weightString = NSMutableAttributedString(string:"\t \(String(pokemonDetails!.weight)) hectograms")
            attributedWeightString.append(weightString)
            self.weightLabel.attributedText = attributedWeightString
            
            let boldTypeText = "Type:"
            let attributedTypeString = NSMutableAttributedString(string:boldTypeText, attributes:attrs)
            let typeString = NSMutableAttributedString(string:"\t \(pokemonDetails?.types.map { $0.type.name }.joined(separator: ", ") ?? "")")
            attributedTypeString.append(typeString)
            self.typeLabel.attributedText = attributedTypeString
            
            group.leave()
        }
        
        group.enter()
        PokemonClient.getPokemonSpecies(id: pokemon.id) { species, error in
            if let genus = species?.genera.filter({ $0.language.name == "en"}).map({ $0.genus })[0] {
                
                let boldSpeciesText = "Species:"
                let attributedSpeciesString = NSMutableAttributedString(string:boldSpeciesText, attributes:attrs)
                let speciesString = NSMutableAttributedString(string:"\t \(genus)")
                attributedSpeciesString.append(speciesString)
                self.speciesLabel.attributedText = attributedSpeciesString
                
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.contentView.isHidden = false
            self.indicator.stopAnimating()
        }
    }
}
