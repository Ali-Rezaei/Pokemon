//
//  PokemonClient.swift
//  Pokemon
//
//  Created by Ali Rezaei on 2020-04-30.
//  Copyright © 2020 Ali Rezaei. All rights reserved.
//

import Foundation

class PokemonClient {
    
    enum Endpoints {
        static let base = "https://pokeapi.co/api/v2"
        
        case getPokemonList
        case getPokemonDetails(Int)
        case getPokemonSpecies(Int)
        
        var stringValue: String {
            switch self {
                case .getPokemonList: return Endpoints.base + "/pokemon" + "?limit=\(151)"
                
                case .getPokemonDetails(let id): return Endpoints.base + "/pokemon" + "/\(id)"
                
            case .getPokemonSpecies(let id): return Endpoints.base +
                "/pokemon-species" + "/\(id)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
        
        return task
    }
    
    class func getPokemonList(completion: @escaping ([Pokemon], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getPokemonList.url, responseType: PokemonListResponse.self) { response, error in
            if let response = response {
                completion(response.results.asDomainModel(), nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func getPokemonDetails(id: Int, completion: @escaping (PokemonDetailsResponse?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getPokemonDetails(id).url, responseType: PokemonDetailsResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func getPokemonSpecies(id: Int, completion: @escaping (PokemonSpeciesResponse?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getPokemonSpecies(id).url, responseType: PokemonSpeciesResponse.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func downloadImage(path: String, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: path)!) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
}
