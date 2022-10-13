//
//  PokemonEvolutionView.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import Foundation
import UIKit

class PokemonEvolutionView: UIView {

    let pokemon: Pokemon
    let size: CGSize

    private lazy var pokemonImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    init(pokemon: Pokemon, size: CGSize) {

        self.pokemon = pokemon
        self.size = size

        super.init(frame: .zero)

        if let imageData = pokemon.profileImageData {

            self.pokemonImageView.image = UIImage(data: imageData) ?? UIImage()
        }

        self.setViewStyle()
        self.createSubviews()
        self.createConstraints()
    }

    private func setViewStyle() {

        self.layer.cornerRadius = 2.5
    }

    private func createSubviews() {

        addSubview(self.pokemonImageView)
    }

    private func createConstraints() {

        NSLayoutConstraint.activate([

            self.pokemonImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2.5),
            self.pokemonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2.5),
            self.pokemonImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2.5),
            self.pokemonImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2.5),
            self.heightAnchor.constraint(equalToConstant: size.height),
            self.widthAnchor.constraint(equalToConstant: size.width),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
