//
//  Networking.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation
import Alamofire

class NetworkAdapter {

    let route: RouteProtocol

    init(route: RouteProtocol) {
        self.route = route
    }

    func request<T:Decodable>(with type: T.Type, completion: @escaping(T, Error?) -> Void) {

        let requestConfigs = self.route.getRoute()

        AF.request(requestConfigs.path.getPath(),
                   method: requestConfigs.method,
                   parameters: requestConfigs.parameters).response { response in

            do {

                let result = try JSONDecoder().decode(type.self, from: response.data ?? Data())

                completion(result, nil)

            } catch {

                print("error")
            }
        }
    }
}
