//
//  PokemonDetails.swift
//  PokeDex
//
//  Created by Bennett Smith on 2/18/24.
//

import Foundation

struct PokemonDetails: Hashable {
    let id: Int
    let name: String
    var imageURL: URL?
    let height: Int
    let weight: Int

    init?(details: PokemonDetailEntity) {
        self.id = details.pokemon.id
        self.name = details.pokemon.name
        self.imageURL = URL(string: details.pokemon.imageURL)
        self.height = details.height
        self.weight = details.weight
    }
}
