//
//  MainViewController.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 08/10/22.
//

import UIKit

class MainViewController: UIViewController, UISearchResultsUpdating, UINavigationBarDelegate {

    weak var coordinator: MainCoordinator?
    var viewModel: MainViewModel = MainViewModel()

    private var pokemonDetailList = [Pokemon]()
    private var filteredPokemonList = [Pokemon]()

    var tableView: UITableView = {

        let tableView = UITableView()

        tableView.register(MainPokemonListTableViewCell.self,
                           forCellReuseIdentifier: "MainPokemonListTableViewCell")
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    var profileView: MainPokemonProfileView = MainPokemonProfileView()
    var profileViewHeightConstraint: NSLayoutConstraint?

    let searchController: UISearchController = {

        let search = UISearchController(searchResultsController: nil)

        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search pokemon"
        search.searchBar.barTintColor = .white
        search.searchBar.searchTextField.backgroundColor = UIColor.white

        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        self.setGradientBackground()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.profileView.delegate = self

        self.searchController.searchResultsUpdater = self

        navigationItem.searchController = self.searchController

        let navigationBarAppearace = UINavigationBar.appearance()

        navigationBarAppearace.tintColor = UIColor.orange
        navigationBarAppearace.barTintColor = UIColor.orange

        title = "Pokedex"

        self.setupNavigationBar()
        view.addSubview(profileView)
        view.addSubview(tableView)
        self.profileView.translatesAutoresizingMaskIntoConstraints = false

        self.profileViewHeightConstraint = profileView.heightAnchor.constraint(equalToConstant: 0)
        self.profileViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([

            self.profileView.topAnchor.constraint(equalTo: view.topAnchor),
            self.profileView.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.profileView.rightAnchor.constraint(equalTo: view.rightAnchor),

            self.tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 32),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        self.getPokemonList()
    }

    func setupNavigationBar() {

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(hex: "#6A81CC")

        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }

    func updateSearchResults(for searchController: UISearchController) {

        guard let text = searchController.searchBar.text else { return }
        print(text)

        self.filteredPokemonList = text.isEmpty ? self.pokemonDetailList : self.pokemonDetailList.filter({(pokemon: Pokemon) -> Bool in

            return pokemon.name?.range(of: text, options: .caseInsensitive) != nil
        })

        self.tableView.reloadData()
    }

    private func getPokemonList () {

        self.viewModel.getPokemonList() { pokemonList, error in

            self.getPokemonProfile(pokemonList: pokemonList)
        }
    }

    private func getPokemonProfile (pokemonList: [PokemonResult]) {

        let group: DispatchGroup = DispatchGroup()

        pokemonList.forEach { pokemon in

            group.enter()

            self.viewModel.getPokemonProfile(with: pokemon.name ?? "") { pokemonDetail, error in

                self.pokemonDetailList.append(pokemonDetail)
                self.filteredPokemonList.append(pokemonDetail)

                group.leave()
            }

            group.notify(queue: .main) {

                self.filteredPokemonList = self.filteredPokemonList.sorted(by: {$0.id ?? 0 < $1.id ?? 0})
                self.tableView.reloadData()
            }
        }
    }

    private func setGradientBackground() {

        let colorTop =  UIColor(hex: "#668BDC").cgColor
        let colorBottom = UIColor(hex: "#4560B2").cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds

        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

    private func updateProfileVisibility(isHidden: Bool) {

        self.profileView.isHidden = isHidden
        self.profileViewHeightConstraint?.constant = isHidden ? 0 : 400

        UIViewPropertyAnimator(duration: 0.2, curve: .easeIn) {

            self.view.layoutIfNeeded()

        }.startAnimation()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.filteredPokemonList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPokemonListTableViewCell",
                                                       for: indexPath) as? MainPokemonListTableViewCell
        else { return UITableViewCell() }

        let currentPokemon = self.filteredPokemonList[indexPath.row]

        if let image: UIImage = UIImage(data: currentPokemon.profileImageData ?? Data(),
                                        scale: 1) {

            cell.configureCellData(name: currentPokemon.name ?? "",
                                   pokemonNumber: currentPokemon.id ?? 0,
                                   image: image)
            return cell
        }

        cell.configureCellData(name: currentPokemon.name ?? "",
                               pokemonNumber: currentPokemon.id ?? 0)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedPokemon = self.filteredPokemonList[indexPath.row]

        self.updateProfileVisibility(isHidden: false)
        profileView.configureViewData(pokemon: selectedPokemon)
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
            indexPathForSelectedRow == indexPath {
            self.updateProfileVisibility(isHidden: true)
            tableView.deselectRow(at: indexPath, animated: false)
            return nil
        }
        return indexPath
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row + 1 == self.pokemonDetailList.count {

            self.getPokemonList()
        }
    }
}

extension MainViewController: MainPokemonProfileViewDelegate {

    func showPokemonDetails(pokemon: Pokemon) {

        self.coordinator?.pokemonDetail(pokemon: pokemon)
    }
}
