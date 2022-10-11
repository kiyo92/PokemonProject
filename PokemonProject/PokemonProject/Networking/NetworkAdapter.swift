//
//  Networking.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import Foundation
import Alamofire

class NetworkAdapter {

    let route: RouteProtocol?

    init(route: RouteProtocol? = nil) {
        self.route = route
    }

    func request<T:Decodable>(with type: T.Type, completion: @escaping(T, Error?) -> Void) {

        guard let requestConfigs = self.route?.getRoute() else { return }

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

    func request(with imageUrl: String, completion: @escaping(Data, Error?) -> Void) {

        AF.request(imageUrl, method: .get).response{ response in

           switch response.result {
            case .success(let responseData):
               guard let data = responseData else { return }
               completion(data, nil)

            case .failure(let error):
               completion(Data(), error)
            }
        }
    }
}
