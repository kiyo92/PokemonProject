//
//  MovePath.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation

class MovePath: PathProtocol {

    enum Path {

        case moveDetail(name: String)
    }

    let path: Path

    init(path: Path) {

        self.path = path
    }

    func getPath() -> String {

        switch path {
            
        case .moveDetail(let name):
            
            return "https://pokeapi.co/api/v2/move/\(name)/"
        }
    }
}
