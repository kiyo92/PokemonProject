//
//  Move.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import Foundation

struct Move: Codable {

    let id: Int?
    let name: String?
    let effectEntries: [MoveEffect]?
    let pp: Int?
    let power: Int?
    let accuracy: Int?
    let type: MoveType?

    enum CodingKeys: String, CodingKey{

        case id
        case name
        case pp
        case power
        case accuracy
        case type
        case effectEntries = "effect_entries"
    }
}

struct MoveEffect: Codable {

    let effect: String?
}

struct MoveType: Codable {

    let name: String?
}
