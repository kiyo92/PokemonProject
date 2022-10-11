//
//  AuthCoordinator.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import Foundation
import UIKit

class AuthCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {

        let vc = LoginViewController()
        self.navigationController.delegate = self
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

    func dismissChildCoordinator (with child: Coordinator?) {

        for (index, coordinator) in children.enumerated() {

            if child === coordinator {

                children.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {

        guard let originVC = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        if navigationController.viewControllers.contains(originVC) {

            return
        }

        if let mainViewController = originVC as? MainViewController {

            self.dismissChildCoordinator(with: mainViewController.coordinator)
        }
    }
}
