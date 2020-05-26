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
    @IBOutlet weak var errorView: UILabel!
    
    var pokemon: Pokemon!
    var caseError:Error?
    
    override func viewDidLoad() {
        
        nameLabel.text = "#\(pokemon.id)\t \(pokemon.name)"
        
        let group = DispatchGroup()
        
        group.enter()
        PokemonClient.getPokemonDetails(id: pokemon.id) { pokemonDetails, error in
            group.leave()
            if let _ = error {
                self.caseError = error
                return
            }
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
            
            if let height = pokemonDetails?.height {
                self.heightLabel.attributedText = Helper.getAttributedString(boldText: "Height:", myString: "\t \(height) decimetres")
            }
            if let weight = pokemonDetails?.weight {
                self.weightLabel.attributedText = Helper.getAttributedString(boldText: "Weight:", myString: "\t \(weight) hectograms")
            }
            self.typeLabel.attributedText = Helper.getAttributedString(boldText: "Type:", myString: "\t \(pokemonDetails?.types.sorted { $0.slot < $1.slot }.map { $0.type.name.capitalizingFirstLetter() }.joined(separator: ", ") ?? "")")
        }
        
        group.enter()
        PokemonClient.getPokemonSpecies(id: pokemon.id) { species, error in
            group.leave()
            if let _ = error {
                self.caseError = error
                return
            }
            if let genus = species?.genera.filter({ $0.language.name == "en"}).map({ $0.genus })[0] {
                self.speciesLabel.attributedText = Helper.getAttributedString(boldText: "Species:", myString: "\t \(genus)")
            }
        }
        group.notify(queue: .main) {
            self.indicator.stopAnimating()
            if(self.caseError == nil) {
                self.contentView.isHidden = false
            } else {
                self.errorView.isHidden = false
            }
        }
    }
}
