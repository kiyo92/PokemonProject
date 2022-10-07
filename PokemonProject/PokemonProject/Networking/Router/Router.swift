//
//  PokemonRoutes.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation
import Alamofire

class Router: RouteProtocol {

    private let route: RouteModel

    init(route: RouteModel) {

        self.route = route
    }

    func getRoute() -> RouteModel {

        return self.route
    }
}
