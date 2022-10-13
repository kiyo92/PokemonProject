//
//  PokemonPath.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation

class PokemonPath: PathProtocol {

    enum Path {

        case pokemonList(offset: Int)
        case pokemonDetail(name: String)
        case pokemonSpecies(id: Int)
    }

    let path: Path

    init(path: Path) {

        self.path = path
    }

    func getPath() -> String {

        switch path {

        case .pokemonDetail(let name):

            return "https://pokeapi.co/api/v2/pokemon/\(name)/"

        case .pokemonList(let offset):

            return "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)"

        case .pokemonSpecies(let id):

            return "https://pokeapi.co/api/v2/pokemon-species/\(id)/"
        }
    }
}
