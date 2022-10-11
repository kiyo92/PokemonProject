//
//  MainViewModel.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 09/10/22.
//

import Foundation

class MainViewModel {

    private var currentPage: Int = 0

    func getPokemonList(completion: @escaping([PokemonResult], Error?) -> Void) {

        let route = RouteModel(path: PokemonPath(path: .pokemonList(offset: currentPage * 20)))
        let adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: PokemonList.self) { result, error in

            guard let results = result.results else { return }

            self.currentPage += 1
            completion(results, error)
        }
    }

    func getPokemonProfile(with name: String, completion: @escaping(Pokemon, Error?) -> Void) {

        let route = RouteModel(path: PokemonPath(path: .pokemonDetail(name: name)))
        let adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: Pokemon.self) { [weak self] result, error in

            self?.getPokemonImage(with: result.sprites?.other?.home?.front_default) { imageData, imageError in

                var pokemon = result
                pokemon.profileImageData = imageData

                completion(pokemon, error)
            }

        }
    }

    private func getPokemonImage(with url: String?, completion: @escaping(Data, Error?) -> Void) {

        let adapter = NetworkAdapter()

        adapter.request(with: url ?? "") { imageData, error in

            completion(imageData, error)
        }
    }
}
