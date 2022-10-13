//
//  PokemonCoordinator.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 12/10/22.
//

import Foundation
import UIKit

class PokemonCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {}

    func start(with pokemon: Pokemon) {

        let vc = PokemonDetailViewController(pokemon: pokemon)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func moveDetail(with move: Move) {

        let vc = MoveDetailViewController(move: move)
        vc.coordinator = self
        vc.preferredContentSize = .init(width: 500, height: 800)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController.topViewController?.present(vc, animated: true, completion: nil)
    }

    func dismiss(_ vc: UIViewController) {

        vc.dismiss(animated: true)
    }

    func dismissCoordinator() {

        let parent = self.parent as? MainCoordinator
        parent?.dismissChildCoordinator(with: self)
    }
}
