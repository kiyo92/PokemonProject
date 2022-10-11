//
//  Pokemon.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation

struct Pokemon: Codable {

    let id: Int?
    let moves: [PokemonMoves]?
    let sprites: PokemonSprites?
    let name: String?
    let types: [PokemonTypes]?
    var profileImageData: Data?
}

struct PokemonSprites: Codable {

    let other: PokemonSpritesOther?
}

struct PokemonTypes: Codable {

    let type: PokemonType?
}

struct PokemonType: Codable {

    let name: String?
}

struct PokemonSpritesOther: Codable {

    let home: PokemonSpritesHome?
}

struct PokemonSpritesHome: Codable {

    let front_default: String?
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


