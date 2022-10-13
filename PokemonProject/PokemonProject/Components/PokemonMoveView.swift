//
//  PokemonMoveView.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 12/10/22.
//

import UIKit

class PokemonMoveView: UIStackView {

    private let move: Move

    let moveNameLabel: UILabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black

        return label
    }()
    
    var attackTypeView: GradientView

    let moveTypeLabel: UILabel = {

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

    init(move: Move) {

        self.move = move
        self.moveNameLabel.text = move.name?
            .capitalized
            .replacingOccurrences(of: "-", with: " ")

        let typeName = move.type?.name ?? ""
        let color = UIColor().getColorBytype(pokemonType: typeName)

        self.attackTypeView = GradientView(topColor: color,
                                      bottomColor: color.darker() ?? UIColor())
        self.moveTypeLabel.text = move.type?.name?.capitalized ?? ""

        super.init(frame: CGRect.zero)

        self.createSubviews()
        self.createConstraints()

        distribution = .fillEqually
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        spacing = 10
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        super.layoutSubviews()
        self.attackTypeView.roundCorners(topLeft: 7.5,
                                         topRight: 7.5,
                                         bottomLeft: 7.5,
                                         bottomRight: 7.5)

    }

    func createSubviews() {

        addArrangedSubview(self.moveNameLabel)
        addArrangedSubview(self.attackTypeView)
        self.attackTypeView.addSubview(self.moveTypeLabel)
    }

    func createConstraints() {

        self.attackTypeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            self.moveNameLabel.heightAnchor.constraint(equalToConstant: 60),
            self.moveNameLabel.topAnchor.constraint(equalTo: topAnchor),
            self.moveNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),

            self.attackTypeView.heightAnchor.constraint(equalToConstant: 40),
            self.attackTypeView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            self.attackTypeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            self.moveTypeLabel.leadingAnchor.constraint(equalTo: self.attackTypeView.leadingAnchor),
            self.moveTypeLabel.trailingAnchor.constraint(equalTo: self.attackTypeView.trailingAnchor),
            self.moveTypeLabel.centerYAnchor.constraint(equalTo: self.attackTypeView.centerYAnchor)
        ])
    }
}
