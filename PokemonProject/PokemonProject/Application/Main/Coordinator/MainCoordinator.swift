//
//  MainCoordinator.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {

        let vc = MainViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func pokemonDetail(pokemon: Pokemon) {

        let child = PokemonCoordinator(navigationController: self.navigationController)
        child.parent = self
        children.append(child)
        child.start(with: pokemon)
    }

    func dismissChildCoordinator (with child: Coordinator?) {

        for (index, coordinator) in children.enumerated() {

            if child === coordinator {

                children.remove(at: index)
                break
            }
        }
    }
}
