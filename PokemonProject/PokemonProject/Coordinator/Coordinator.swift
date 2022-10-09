//
//  Coordinator.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import UIKit

public protocol Coordinator : AnyObject {

    var children: [Coordinator] { get set }

    var navigationController: UINavigationController { get set} 

    func start()
}
