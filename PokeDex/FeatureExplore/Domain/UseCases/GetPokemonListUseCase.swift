//
//  FetchPokemonsUseCase.swift
//  PokeDex
//
//  Created by Muhammad Adha Fajri Jonison on 28/08/23.
//

import Foundation

class GetPokemonListUseCase {
    typealias PokemonListPagePresenter = @MainActor (_ offset: Int, _ items: [PokemonListItem]) -> Void
    let repository: ExploreRepositoryProtocol
    
    init(pokeDexRepository: ExploreRepositoryProtocol) {
        self.repository = pokeDexRepository
    }
    
    func execute(limit: Int = 20, offset: Int, presenter presentPokemonListPage: @escaping PokemonListPagePresenter) async throws -> Void {
        let entities = try await repository.fetchPokemons(limit: limit, offset: offset)
        let models = entities.compactMap({ entity in PokemonListItem(pokemon: entity)})
        await presentPokemonListPage(offset, models)
    }
}
