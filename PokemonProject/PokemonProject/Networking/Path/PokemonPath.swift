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
        case pokemonDetail(id: Int)
    }

    let path: Path

    init(path: Path) {

        self.path = path
    }

    func getPath() -> String {

        switch path {

        case .pokemonDetail(let id):

            return "https://pokeapi.co/api/v2/pokemon/\(id)/"

        case .pokemonList(let offset):

            return "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)"
        }
    }
}
