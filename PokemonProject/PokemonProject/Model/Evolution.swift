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
}

struct Species: Codable {

    let name: String?
    let url: String?
}
