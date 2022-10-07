//
//  ViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 07/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let route = RouteModel(path: PokemonPath(path: .pokemonList(offset: 0)))
        var adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: Pokemon.self) { result, error in

            guard let results = result.results else { return }

            results.enumerated().forEach { (id, result) in

                if let name = result.name {

                    print(id, name)
                }
            }
        }


        let routeMove = RouteModel(path: MovePath(path: .moveDetail(id: 1)))
        adapter = NetworkAdapter(route: Router(route: routeMove))
        /*
        adapter.request() { result, error in

        }
         */
    }


}

