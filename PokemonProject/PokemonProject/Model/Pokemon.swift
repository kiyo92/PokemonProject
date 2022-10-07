//
//  Pokemon.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation

struct Pokemon: Codable {

    let results: [PokemonResult]?
}

struct PokemonResult: Codable {

    let name: String?
}
