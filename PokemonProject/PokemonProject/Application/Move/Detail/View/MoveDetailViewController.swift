//
//  MoveDetailViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 12/10/22.
//

import UIKit

class MoveDetailViewController: UIViewController {

    private let move: Move
    weak var coordinator: PokemonCoordinator?

    private lazy var container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.6

        return view
    }()

    private lazy var attackNameLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)

        return label
    }()

    private lazy var attackTypeLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white

        return label
    }()

    private lazy var attackPPLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private lazy var attackPowerLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private lazy var attackAccuracyLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private lazy var attackEffectLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private var attackTypeView: GradientView

    init(move: Move) {

        self.move = move
        let color = UIColor().getColorBytype(pokemonType: self.move.type?.name ?? "")
        self.attackTypeView = GradientView(topColor: color,
                                           bottomColor: color.darker() ?? UIColor(),
                                           radius: 5)

        super.init(nibName: nil, bundle: nil)
        
        self.attackNameLabel.text = self.move.name?
            .capitalized
            .replacingOccurrences(of: "-", with: " ")
        self.attackTypeLabel.text = self.move.type?.name?.capitalized
        self.attackEffectLabel.text = self.move.effectEntries?.first?.effect ?? ""
        self.attackPPLabel.text = "PP: \(self.move.pp ?? 0)"
        self.attackPowerLabel.text = "Atk. Power: \(self.move.power ?? 0)"
        self.attackAccuracyLabel.text = "Accuracy: \(self.move.accuracy ?? 0)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        self.createSubviews()
        self.createConstraints()

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tap)
    }

    @objc
    private func dismissView (){

        self.coordinator?.dismiss(self)
    }

    private func createSubviews() {

        view.addSubview(self.container)
        self.container.addSubview(self.attackNameLabel)
        self.attackTypeView.translatesAutoresizingMaskIntoConstraints = false
        self.container.addSubview(self.attackTypeView)
        self.attackTypeView.addSubview(self.attackTypeLabel)
        self.container.addSubview(self.attackPPLabel)
        self.container.addSubview(self.attackEffectLabel)
        self.container.addSubview(self.attackPowerLabel)
        self.container.addSubview(self.attackAccuracyLabel)
    }

    private func createConstraints() {

        let attackEffetchBottomCons = self.attackEffectLabel.bottomAnchor
            .constraint(equalTo: self.container.bottomAnchor, constant: -16)

        attackEffetchBottomCons.priority = UILayoutPriority(500)

        NSLayoutConstraint.activate([

            self.container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.container.heightAnchor.constraint(equalToConstant: view.bounds.size.width / 1.3),
            self.container.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5),

            self.attackNameLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 20),
            self.attackNameLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor,
                                                          constant: 16),
            self.attackNameLabel.trailingAnchor.constraint(equalTo: self.container.centerXAnchor,
                                                           constant: 32),
            self.attackTypeView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 16),
            self.attackTypeView.trailingAnchor.constraint(equalTo: self.container.trailingAnchor,
                                                           constant: -16),

            self.attackTypeLabel.topAnchor.constraint(equalTo: self.attackTypeView.topAnchor, constant: 8),
            self.attackTypeLabel.leadingAnchor.constraint(equalTo: self.attackTypeView.leadingAnchor,
                                                           constant: 8),
            self.attackTypeLabel.trailingAnchor.constraint(equalTo: self.attackTypeView.trailingAnchor,
                                                           constant: -8),
            self.attackTypeLabel.bottomAnchor.constraint(equalTo: self.attackTypeView.bottomAnchor,
                                                           constant: -8),

            self.attackPPLabel.topAnchor.constraint(equalTo: self.attackTypeLabel.bottomAnchor,
                                                    constant: 16),
            self.attackPPLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor,
                                                            constant: 16),
            self.attackPPLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor,
                                                             constant: -16),

            self.attackPowerLabel.topAnchor.constraint(equalTo: self.attackPPLabel.bottomAnchor,
                                                       constant: 4),
            self.attackPowerLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor,
                                                            constant: 16),
            self.attackPowerLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor,
                                                             constant: -16),

            self.attackAccuracyLabel.topAnchor.constraint(equalTo: self.attackPowerLabel.bottomAnchor,
                                                          constant: 4),
            self.attackAccuracyLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor,
                                                            constant: 16),
            self.attackAccuracyLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor,
                                                             constant: -16),

            self.attackEffectLabel.topAnchor.constraint(equalTo: self.attackAccuracyLabel.bottomAnchor, constant: 16),
            self.attackEffectLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor,
                                                            constant: 16),
            self.attackEffectLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor,
                                                             constant: -16),
            attackEffetchBottomCons

        ])
    }
}
