//
//  PokemonDetailViewModel.swift
//  PokemonProject
//
//  Created by Joao Marcus Dionisio Araujo on 11/10/22.
//

import Foundation

class PokemonDetailViewModel {

    private let pokemon: Pokemon

    init(pokemon: Pokemon) {

        self.pokemon = pokemon
    }

    func getEvolutionData(completion: @escaping([Pokemon], Error?) -> Void) {

        self.getEvolutionChainId() { chainId, error in

            let route = RouteModel(path: EvolutionPath(path: .evolutionChain(id: chainId)))
            let adapter = NetworkAdapter(route: Router(route: route))

            let group = DispatchGroup()

            var pokemonEvolutionList = [Pokemon]()

            adapter.request(with: Evolution.self) { result, error in

                let pokemonNames: [String] = self.flattenEvolve(chain: result.chain?.evolvesTo)

                pokemonNames.forEach { name in
                    group.enter()
                    self.getPokemonProfile(with: name) { profile, error in

                        pokemonEvolutionList.append(profile)
                        group.leave()
                    }
                }

                group.notify(queue: .main) {

                    completion(pokemonEvolutionList, error)
                }
            }
        }
    }

    private func getPokemonProfile(with name: String, completion: @escaping(Pokemon, Error?) -> Void) {

        let route = RouteModel(path: PokemonPath(path: .pokemonDetail(name: name)))
        let adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: Pokemon.self) { [weak self] result, error in

            self?.getPokemonImage(with: result.sprites?.other?.home?.front_default) { imageData, imageError in

                var pokemon = result
                pokemon.profileImageData = imageData

                completion(pokemon, error)
            }

        }
    }

    private func getEvolutionChainId(completion: @escaping(Int, Error?) -> Void) {

        let route = RouteModel(path: PokemonPath(path: .pokemonSpecies(id: self.pokemon.id ?? 0)))
        let adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: PokemonSpecies.self) { result, error in

            let number = Int(result.evolutionChain?.url?
                .components(separatedBy: CharacterSet.decimalDigits.inverted).joined().dropFirst() ?? "")

            completion(number ?? 0, error)
        }
    }

    private func getPokemonImage(with url: String?, completion: @escaping(Data, Error?) -> Void) {

        let adapter = NetworkAdapter()

        adapter.request(with: url ?? "") { imageData, error in

            completion(imageData, error)
        }
    }

    func getPokemonMoveData(completion: @escaping([Move], Error?) -> Void) {

        var moves = [Move]()
        let group = DispatchGroup()
        
        self.pokemon.moves?.forEach { move in
            
            group.enter()
            let route = RouteModel(path: MovePath(path: .moveDetail(name: move.move?.name ?? "")))
            let adapter = NetworkAdapter(route: Router(route: route))

            adapter.request(with: Move.self) { result, error in

                moves.append(result)
                group.leave()
            }
        }

        group.notify(queue: .main) {

            completion(moves.sorted(by: {$0.id ?? 0 < $1.id ?? 0}), nil)
        }
    }

    private func flattenEvolve(chain: [Chain]?, pokemonNames: [String] = []) -> [String]{

        var pokemonNames = pokemonNames

        pokemonNames.append(chain?.first?.species?.name ?? "")

        if(chain?.first?.evolvesTo?.count ?? 0 > 0) {

            return self.flattenEvolve(chain: chain?.first?.evolvesTo ?? [], pokemonNames: pokemonNames)
        }

        return pokemonNames
    }
}

