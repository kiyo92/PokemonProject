//
//  PokemonDetailViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    let pokemon: Pokemon

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


    init(pokemon: Pokemon) {

        self.pokemon = pokemon
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

        let mainType = self.pokemon.types?.first
        view.backgroundColor = UIColor().getColorBytype(pokemonType: mainType?.type?.name ?? "")
        self.createSubviews()
        self.createConstraints()
    }

    func createSubviews() {

        view.addSubview(self.pokemonNameLabel)
        view.addSubview(self.collectionView)
    }

    func createConstraints() {

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            self.pokemonNameLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -25),
            self.pokemonNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 32),
        ])
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
