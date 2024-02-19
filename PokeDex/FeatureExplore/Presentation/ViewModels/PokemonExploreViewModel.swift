//
//  PokemonExploreViewModel.swift
//  PokeDex
//
//  Created by Muhammad Adha Fajri Jonison on 31/08/23.
//

import Foundation

@MainActor
class PokemonExploreViewModel: ObservableObject {
    private let getPokemonListUseCase: GetPokemonListUseCase = GetPokemonListUseCase(pokeDexRepository: ExploreRepository.shared)
    
    @Published var pokemonList: [PokemonListItem] = [PokemonListItem]()
    @Published var offset: Int = 20
    
    func handleOnAppear(pokemon: PokemonListItem) {
        guard pokemonList.last == pokemon else { return }
        
        increaseOffset(value: Constants.pokeApiPokemonListlimit)
        loadPokemonList()
    }
    
    func loadPokemonList() {
        Task {
            do {
                try await getPokemonListUseCase.execute(limit: 20, offset: offset, presenter: presentPokemonListPage)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func presentPokemonListPage(offset: Int, items: [PokemonListItem]) {
        pokemonList += items.compactMap({ $0 })
    }
    
    private func increaseOffset(value: Int) {
        offset += value
    }
}
