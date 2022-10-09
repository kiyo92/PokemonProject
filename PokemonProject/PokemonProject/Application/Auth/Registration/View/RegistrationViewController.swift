//
//  RegistrationViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import UIKit

class RegistrationViewController: UIViewController, StoryboardProtocol {

    var coordinator: AuthCoordinator?

    var centerView: UIView = {

        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.backgroundColor = .white

        view.addSubview(centerView)
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerView.heightAnchor.constraint(equalToConstant: 300),
            centerView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
