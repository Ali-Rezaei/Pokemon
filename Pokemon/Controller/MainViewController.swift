//
//  MainViewController.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-29.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UILabel!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokemonClient.getPokemonList() { pokemons, error in
            self.indicator.stopAnimating()
            if let _ = error {
               self.errorView.isHidden = false
            } else {
                PokemonModel.pokemonList = pokemons
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.pokemon = PokemonModel.pokemonList[selectedIndex]
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonModel.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"PokemonCell") as! PokemonCell
        let pokemon = PokemonModel.pokemonList[indexPath.row]
        cell.setPokemon(pokemon: pokemon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
