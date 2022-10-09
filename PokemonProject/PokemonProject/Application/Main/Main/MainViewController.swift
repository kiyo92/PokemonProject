//
//  MainViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import UIKit

class MainViewController: UIViewController {

    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        
        self.coordinator?.dismissCoordinator()
    }

}
