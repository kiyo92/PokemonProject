//
//  EvolutionPath.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import Foundation

class EvolutionPath: PathProtocol {

    enum Path {

        case evolutionChain(id: Int)
    }

    let path: Path

    init(path: Path) {

        self.path = path
    }

    func getPath() -> String {

        switch path {

        case .evolutionChain(let id):

            return "https://pokeapi.co/api/v2/evolution-chain/\(id)/"
        }
    }
}
