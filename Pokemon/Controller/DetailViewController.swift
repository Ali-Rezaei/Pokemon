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
                    self.frontImage.image = self.getImage(data: data)
                }
            }
            if let path = pokemonDetails?.sprites.urlBack {
                PokemonClient.downloadImage(path: path) { data, error in
                    self.backImage.image = self.getImage(data: data)
                }
            }
            
            self.heightLabel.attributedText = self.getAttributedString(boldText: "Height:", myString: "\t \(String(pokemonDetails!.height)) decimetres")

            self.weightLabel.attributedText = self.getAttributedString(boldText: "Weight:", myString: "\t \(String(pokemonDetails!.weight)) hectograms")

            self.typeLabel.attributedText = self.getAttributedString(boldText: "Type:", myString: "\t \(pokemonDetails?.types.map { $0.type.name.capitalizingFirstLetter() }.joined(separator: ", ") ?? "")")
            
            group.leave()
        }
        
        group.enter()
        PokemonClient.getPokemonSpecies(id: pokemon.id) { species, error in
            if let genus = species?.genera.filter({ $0.language.name == "en"}).map({ $0.genus })[0] {
                
                self.speciesLabel.attributedText = self.getAttributedString(boldText: "Species:", myString: "\t \(genus)")
                
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.contentView.isHidden = false
            self.indicator.stopAnimating()
        }
    }
    
    private func getAttributedString(boldText: String, myString: String) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let textString = NSMutableAttributedString(string:myString)
        attributedString.append(textString)
        return attributedString
    }
    
    private func getImage(data : Data?) -> UIImage? {
        guard let data = data else {
            return nil
        }
        let image = UIImage(data: data)
        return image
    }
}
