//
//  PokemonTypeView.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import UIKit

class PokemonTypeView: UIView {

    let pokemonType: String

    private lazy var typeNameLabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)

        return label
    }()

    init(typeName: String) {

        self.pokemonType = typeName.lowercased()

        super.init(frame: .zero)
        self.typeNameLabel.text = typeName.capitalized
        self.setViewStyle()
        self.createSubviews()
        self.createConstraints()
    }

    private func setViewStyle() {

        self.layer.cornerRadius = 2.5
        self.backgroundColor = UIColor().getColorBytype(pokemonType: self.pokemonType)
    }

    private func createSubviews() {

        addSubview(self.typeNameLabel)
    }

    private func createConstraints() {

        NSLayoutConstraint.activate([

            self.typeNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            self.typeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            self.typeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            self.typeNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
