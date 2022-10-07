//
//  MovePath.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation

class MovePath: PathProtocol {

    enum Path {

        case moveDetail(id: Int)
    }

    let path: Path

    init(path: Path) {

        self.path = path
    }

    func getPath() -> String {

        switch path {
            
        case .moveDetail(let id):
            
            return "https://pokeapi.co/api/v2/pokemon/\(id)/"
        }
    }
}
