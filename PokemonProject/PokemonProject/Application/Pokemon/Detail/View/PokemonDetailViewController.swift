//
//  PokemonDetailViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    let pokemon: Pokemon
    var coordinator: PokemonCoordinator?
    let viewModel: PokemonDetailViewModel

    let scrollView = UIScrollView()

    var containerView = UIView()

    private lazy var loading: UIActivityIndicatorView = {

        let loading = UIActivityIndicatorView(style: .large)
        loading.hidesWhenStopped = true
        loading.color = .darkGray
        loading.translatesAutoresizingMaskIntoConstraints = false

        return loading
    }()

    let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PokemonDetailCollectionViewCell.self,
                                forCellWithReuseIdentifier: "PokemonDetailCollectionViewCell")

        return collectionView
    }()

    private let pokemonNameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 56, weight: .bold)
        label.textColor = .white
        label.layer.opacity = 0.7

        return label
    }()

    private let evolutionLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "Evolutions"

        return label
    }()

    private lazy var evolutionStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private var pokemonMovesLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.text = "Moves"

        return label
    }()

    private lazy var moveStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.layer.opacity = 0.75
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    init(pokemon: Pokemon) {

        self.pokemon = pokemon
        self.viewModel = PokemonDetailViewModel(pokemon: pokemon)
        self.pokemonNameLabel.text = pokemon.name?.uppercased() ?? ""

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.createSubviews()
        self.createConstraints()
        self.getEvolutionData()
        self.setupMoveStackView()

        title = self.pokemon.name?.capitalized

        let mainType = self.pokemon.types?.first
        let backgroundColor = UIColor().getColorBytype(pokemonType: mainType?.type?.name ?? "")

        self.setGradientBackground(topColor: backgroundColor,
                                   bottomColor: backgroundColor.darker() ?? UIColor())

        self.setupNavigationBar(with: backgroundColor.darker())

        self.moveStackView.backgroundColor = backgroundColor.lighter()
        self.moveStackView.layer.borderColor = backgroundColor.darker()?.cgColor
    }

    func setupNavigationBar(with color: UIColor?) {

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.backgroundColor = color

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.standardAppearance = appearance
        navigationBar?.tintColor = .white
        navigationBar?.scrollEdgeAppearance = appearance
    }

    func createSubviews() {
        
        view.addSubview(self.scrollView)
        view.addSubview(loading)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(self.pokemonNameLabel)
        self.containerView.addSubview(self.collectionView)
        self.containerView.addSubview(self.evolutionLabel)
        self.containerView.addSubview(self.evolutionStackView)
        self.containerView.addSubview(self.pokemonMovesLabel)
        self.containerView.addSubview(self.moveStackView)
    }

    func createConstraints() {

        NSLayoutConstraint.activate([

            self.loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            self.scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            self.containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),

            self.collectionView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: (view.bounds.size.height / 2) - 50),

            self.pokemonNameLabel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor,
                                                          constant: -45),
            self.pokemonNameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,
                                                            constant: 32),

            self.evolutionLabel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 32),
            self.evolutionLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                         constant: 16),
            self.evolutionLabel.heightAnchor.constraint(equalToConstant: 22),

            self.evolutionStackView.topAnchor.constraint(equalTo: self.evolutionLabel.bottomAnchor),
            self.evolutionStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                             constant: 16),
            self.evolutionStackView.heightAnchor.constraint(equalToConstant: 100),

            self.pokemonMovesLabel.topAnchor.constraint(equalTo: self.evolutionStackView.bottomAnchor,
                                                                  constant: 16),
            self.pokemonMovesLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                            constant: 16),
            self.pokemonMovesLabel.heightAnchor.constraint(equalToConstant: 22),

            self.moveStackView.topAnchor.constraint(equalTo: self.pokemonMovesLabel.bottomAnchor,
                                                    constant: 16),
            self.moveStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                             constant: 16),
            self.moveStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,
                                                             constant: -16),
            self.moveStackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                            constant: 16),
        ])
    }

    private func setGradientBackground(topColor: UIColor, bottomColor: UIColor) {

        let colorTop =  topColor.cgColor
        let colorBottom = bottomColor.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

    func getEvolutionData() {

        self.loading.startAnimating()

        self.viewModel.getEvolutionData() { result, error in

            result.forEach { pokemon in

                self.evolutionStackView
                    .addArrangedSubview(PokemonEvolutionView(pokemon: pokemon,
                                                             size: CGSize(width: 80,
                                                                          height: 80)))
            }
        }
    }

    @objc
    func showModal(_ sender: MoveTapGesture? = nil) {

        guard let move = sender?.move else { return }
        self.coordinator?.moveDetail(with: move)
    }

    func setupMoveStackView() {

        self.viewModel.getPokemonMoveData() { moves, error in

            moves.forEach { move in

                let view: PokemonMoveView = PokemonMoveView(move: move)
                let tap = MoveTapGesture(target: self, action: #selector(self.showModal(_:)))
                tap.move = move
                view.addGestureRecognizer(tap)

                self.moveStackView.addArrangedSubview(view)
            }

            self.loading.stopAnimating()
        }
    }
}

extension PokemonDetailViewController: UICollectionViewDelegate,
                                       UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout,
                                       UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "PokemonDetailCollectionViewCell",
                                 for: indexPath) as? PokemonDetailCollectionViewCell
        else { return UICollectionViewCell() }

        let image = UIImage(data: pokemon.profileImageData ?? Data()) ?? UIImage()

        cell.configureCellData(with: image)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return self.collectionView.bounds.size
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if decelerate == false {
            self.scrollToNearestVisibleCollectionViewCell()
        }
    }

    func scrollToNearestVisibleCollectionViewCell() {

        self.collectionView.decelerationRate = .fast
        let visibleCenterPos = Float(self.collectionView.contentOffset.x +
                                     (self.collectionView.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude

        for i in 0..<self.collectionView.visibleCells.count {

            let cell = self.collectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            let distance: Float = fabsf(visibleCenterPos - cellCenter)

            if distance < closestDistance {

                closestDistance = distance
                closestCellIndex = self.collectionView.indexPath(for: cell)!.row
            }
        }

        if closestCellIndex != -1 {

            self.collectionView.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

class MoveTapGesture: UITapGestureRecognizer {

    var move: Move?
}
