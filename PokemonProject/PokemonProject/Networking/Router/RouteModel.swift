//
//  Route.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation
import Alamofire

struct RouteModel {

    var method: HTTPMethod = .get
    let path: PathProtocol
    let parameters: Parameters? = nil
}
