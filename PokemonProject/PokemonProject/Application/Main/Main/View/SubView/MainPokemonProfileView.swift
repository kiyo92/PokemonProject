//
//  MainPokemonProfileView.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 09/10/22.
//

import UIKit

protocol MainPokemonProfileViewDelegate: AnyObject {

    func showPokemonDetails(pokemon: Pokemon)
}

class MainPokemonProfileView: UIView {

    weak var delegate: MainPokemonProfileViewDelegate?

    private lazy var container: GradientView = {

        let view = GradientView(topHex: "#C5E0F0", bottomHex: "#8C9EE9")

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var profileImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private var pokemon: Pokemon?

    private lazy var nameLabel: UILabel = {

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.3

        return label
    }()

    private lazy var typesStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var detailsButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage.init(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = UIColor(hex: "#F9E861")

        return button
    }()

    override init(frame: CGRect) {

        super.init(frame: CGRect.zero)
        self.createSubviews()
        self.createConstraints()
        self.detailsButton.addTarget(self, action: #selector(showPokemonDetails), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        super.layoutSubviews()
        self.container.roundCorners(topLeft: 5,
                                    topRight: 5,
                                    bottomLeft: 5,
                                    bottomRight: 5)
        self.detailsButton.roundCorners(topLeft: 10)

        let outerBorder = CALayer()
        outerBorder.borderWidth = 7
        outerBorder.borderColor = UIColor(hex: "#F9E861").cgColor
        outerBorder.frame =  CGRect(origin: CGPoint.zero,
                                    size: CGSize(width: self.container.bounds.size.width,
                                                 height: 250))

        let innerBorder = CALayer()
        innerBorder.frame =  CGRect(origin: CGPoint.zero,
                                    size: CGSize(width: self.container.bounds.size.width,
                                                 height: 250))
        innerBorder.borderWidth = 12
        innerBorder.borderColor = UIColor(hex: "#8BC2EE").cgColor

        container.layer.addSublayer(innerBorder)
        container.layer.addSublayer(outerBorder)

    }

    @objc
    private func showPokemonDetails() {

        guard let pokemon = self.pokemon else { return }
        self.delegate?.showPokemonDetails(pokemon: pokemon)
    }

    func configureViewData(pokemon: Pokemon) {

        self.pokemon = pokemon
        guard let image: UIImage = UIImage(data: pokemon.profileImageData ?? Data(),
                                           scale: 1) else { return }
        self.profileImageView.image = image
        self.nameLabel.text = pokemon.name?.uppercased()
        self.setupPokemonTypes(pokemonTypes: pokemon.types ?? [])
    }

    func createSubviews() {

        addSubview(self.container)
        self.container.addSubview(self.profileImageView)
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.typesStackView)
        addSubview(self.detailsButton)
    }

    func createConstraints() {

        NSLayoutConstraint.activate([

            self.container.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            self.container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            self.container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            self.container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),

            self.profileImageView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 16),
            self.profileImageView.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 16),
            self.profileImageView.trailingAnchor.constraint(equalTo: self.container.centerXAnchor, constant: 0),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 150),

            self.typesStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 32),
            self.typesStackView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor,
                                                         constant: 26),
            self.typesStackView.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -26),

            self.nameLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 26),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -26),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -16),

            self.detailsButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor,
                                                         constant: -7),
            self.detailsButton.widthAnchor.constraint(equalToConstant: 110),
            self.detailsButton.heightAnchor.constraint(equalToConstant: 40),
            self.detailsButton.bottomAnchor.constraint(equalTo: self.container.bottomAnchor,
                                                       constant: -7),

        ])
    }

    func setupPokemonTypes(pokemonTypes: [PokemonTypes]) {

        for item in self.typesStackView.arrangedSubviews {

            self.typesStackView.removeArrangedSubview(item)
            item.removeFromSuperview()
        }

        pokemonTypes.forEach { type in

            self.typesStackView.addArrangedSubview(PokemonTypeView(typeName: type.type?.name ?? "Unknown"))
        }
    }
}
