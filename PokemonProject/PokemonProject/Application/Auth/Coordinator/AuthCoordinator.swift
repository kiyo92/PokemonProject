//
//  AuthCoordinator.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import Foundation
import UIKit

class AuthCoordinator: Coordinator {

    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {

        let vc = LoginViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func register() {

        let vc = RegistrationViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func main () {

        let child = MainCoordinator(navigationController: self.navigationController)
        child.parent = self
        children.append(child)
        child.start()
    }
}
