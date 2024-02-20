//
//  PokemonDetailViewModel.swift
//  PokeDex
//
//  Created by Muhammad Adha Fajri Jonison on 03/09/23.
//

import Foundation

@MainActor
class PokemonDetailViewModel: ObservableObject {
    let getPokemonDetailUseCase = GetPokemonDetailUseCase(repository: DetailRepository())
    
    @Published var pokemonDetail: PokemonDetails?
    
    func loadDetail(id: Int) {
        Task {
            do {
                try await getPokemonDetailUseCase.execute(id: id, presenter: self)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

extension PokemonDetailViewModel: GetPokemonDetailPresenter {
    func presentPokemon(details: PokemonDetails) {
        self.pokemonDetail = details
    }
}
