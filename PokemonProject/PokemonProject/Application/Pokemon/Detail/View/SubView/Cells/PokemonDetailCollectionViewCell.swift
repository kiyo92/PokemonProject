//
//  PokemonDetailCollectionViewCell.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import UIKit

class PokemonDetailCollectionViewCell: UICollectionViewCell {

    private let pokemonImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    override init(frame: CGRect) {

        super.init(frame: .zero)
        
        backgroundColor = .clear
        self.createSubviews()
        self.createConstraints()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }

    func configureCellData(with image: UIImage) {

        self.pokemonImageView.image = image
    }

    private func createSubviews() {

        contentView.addSubview(self.pokemonImageView)
    }

    private func createConstraints() {

        NSLayoutConstraint.activate([

            self.pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.pokemonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.pokemonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
