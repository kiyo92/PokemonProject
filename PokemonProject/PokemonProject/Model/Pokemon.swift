//
//  Pokemon.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation

struct Pokemon: Codable {
    
    let moves: [PokemonMoves]?
}

struct PokemonList: Codable {

    let results: [PokemonResult]?
}

struct PokemonResult: Codable {

    let name: String?
}

struct PokemonMoves: Codable {

    let move: Move?
}


