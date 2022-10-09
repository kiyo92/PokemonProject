//
//  LoginViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import UIKit

public protocol LoginViewControllerDelegate: AnyObject {

    func navigateToNextPage()
}

class LoginViewController: UIViewController, StoryboardProtocol {

    weak var delegate: LoginViewControllerDelegate?
    weak var coordinator: AuthCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        let route = RouteModel(path: PokemonPath(path: .pokemonList(offset: 0)))
        var adapter = NetworkAdapter(route: Router(route: route))

        view.backgroundColor = .white

        adapter.request(with: PokemonList.self) { result, error in

            guard let results = result.results else { return }

            results.enumerated().forEach { (id, pkmResult) in

                if let name = pkmResult.name {

                    print(id, name)
                }
            }
        }


        let routeDetail = RouteModel(path: PokemonPath(path: .pokemonDetail(id: 1)))
        adapter = NetworkAdapter(route: Router(route: routeDetail))

        adapter.request(with: Pokemon.self) { [weak self] result, error in

            guard let moves = result.moves else { return }

            moves.forEach { move in

                if let moveName = move.move?.name as? String, let url = move.move?.url as? String {

                    print(moveName, url)
                }
            }

            self?.coordinator?.register()
        }
    }

}
