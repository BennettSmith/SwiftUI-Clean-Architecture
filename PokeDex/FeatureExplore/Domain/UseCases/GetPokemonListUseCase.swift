//
//  FetchPokemonsUseCase.swift
//  PokeDex
//
//  Created by Muhammad Adha Fajri Jonison on 28/08/23.
//

import Foundation

protocol GetPokemonListPresenter {
    @MainActor func presentPokemonListPage(offset: Int, items: [PokemonListItem])
}

class GetPokemonListUseCase {
    let repository: ExploreRepositoryProtocol
    
    init(pokeDexRepository: ExploreRepositoryProtocol) {
        self.repository = pokeDexRepository
    }
    
    func execute(limit: Int = 20, offset: Int, presenter: GetPokemonListPresenter) async throws -> Void {
        let entities = try await repository.fetchPokemons(limit: limit, offset: offset)
        let models = entities.compactMap({ entity in PokemonListItem(pokemon: entity)})
        await presenter.presentPokemonListPage(offset: offset, items: models)
    }
}
