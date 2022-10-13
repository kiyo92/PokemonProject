//
//  Evolution.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import Foundation

struct Evolution: Codable {

    let chain: Chain?
}

struct Chain: Codable {

    let evolvesTo: [Chain]?
    let species: Species?

    enum CodingKeys: String, CodingKey {

        case evolvesTo = "evolves_to"
        case species
    }
}

struct Species: Codable {

    let name: String?
}
