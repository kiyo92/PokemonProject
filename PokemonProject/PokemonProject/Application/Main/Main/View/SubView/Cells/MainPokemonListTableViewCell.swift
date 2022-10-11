//
//  MainPokemonListTableViewCell.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 10/10/22.
//

import UIKit

class MainPokemonListTableViewCell: UITableViewCell {

    private lazy var container: GradientView = {

        let view = GradientView(topHex: "#FAECBE", bottomHex: "#FEE9B1")
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var pokebalIconView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pokeball-icon")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var pokemonNumber: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var pokemonImage: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var nameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.createSubviews()
        self.createConstraints()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.container.roundCorners(topLeft: CGFloat(self.frame.height / 2),
                                    topRight: 5,
                                    bottomLeft: CGFloat(self.frame.height / 2),
                                    bottomRight: 5)
        backgroundColor = .clear
    }



    func configureCellData(name: String, pokemonNumber: Int, image: UIImage? = UIImage()) {

        self.nameLabel.text = name
        self.pokemonImage.image = image
        self.pokemonNumber.text = "No. \(pokemonNumber)"
    }

    func createSubviews() {

        contentView.addSubview(self.container)
        self.container.addSubview(self.pokebalIconView)
        self.container.addSubview(self.pokemonImage)
        self.container.addSubview(self.pokemonNumber)
        self.container.addSubview(self.nameLabel)
    }

    func createConstraints() {

        NSLayoutConstraint.activate([

            self.container.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: 2.5),
            self.container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: 16),
            self.container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -16),
            self.container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                   constant: -2.5),

            self.pokebalIconView.centerYAnchor.constraint(equalTo: self.container.centerYAnchor),
            self.pokebalIconView.leadingAnchor.constraint(equalTo: self.container.leadingAnchor,
                                                          constant: 16),
            self.pokebalIconView.heightAnchor.constraint(equalToConstant: 50),
            self.pokebalIconView.widthAnchor.constraint(equalToConstant: 50),

            self.pokemonImage.centerYAnchor.constraint(equalTo: self.container.centerYAnchor),
            self.pokemonImage.leadingAnchor.constraint(equalTo: self.pokebalIconView.trailingAnchor,
                                                       constant: 8),
            self.pokemonImage.heightAnchor.constraint(equalToConstant: 50),
            self.pokemonImage.widthAnchor.constraint(equalToConstant: 50),

            self.pokemonNumber.topAnchor.constraint(equalTo: self.container.topAnchor,
                                                    constant: 8),
            self.pokemonNumber.leadingAnchor.constraint(equalTo: self.pokemonImage.trailingAnchor,
                                                        constant: 8),
            self.pokemonNumber.trailingAnchor.constraint(equalTo: self.container.centerXAnchor,
                                                         constant: 20),
            self.pokemonNumber.bottomAnchor.constraint(equalTo: self.container.bottomAnchor,
                                                       constant: -8),

            self.nameLabel.topAnchor.constraint(equalTo: self.container.topAnchor,
                                                constant: 8),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.pokemonNumber.trailingAnchor,
                                                    constant: 8),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor,
                                                     constant: 16),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor,
                                                   constant: -8)
        ])
    }
}
