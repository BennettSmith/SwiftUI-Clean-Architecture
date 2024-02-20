//
//  GetPokemonDetailUseCase.swift
//  PokeDex
//
//  Created by Muhammad Adha Fajri Jonison on 29/08/23.
//

import Foundation

protocol GetPokemonDetailPresenter {
    @MainActor func presentPokemon(details: PokemonDetails)
}

class GetPokemonDetailUseCase {
    let repository: DetailRepositoryProtocol
    
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int, presenter: GetPokemonDetailPresenter) async throws {
        if let pokemonDetailEntity = try await repository.fetchPokemonDetail(id: id) {
            if let pokemonDetails = PokemonDetails(details: pokemonDetailEntity) {
                await presenter.presentPokemon(details: pokemonDetails)
            }
        }
    }
}
