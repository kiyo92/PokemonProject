//
//  StoryboardProtocol.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import Foundation
import UIKit

protocol StoryboardProtocol {

    static func instantiate() -> Self
}

extension StoryboardProtocol where Self: UIViewController {

    static func instantiate() -> Self {

        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: id) as! Self 
    }
}
