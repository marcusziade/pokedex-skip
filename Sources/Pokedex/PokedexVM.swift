import Foundation
import Observation

@Observable
class PokedexViewModel {
    var pokemon: [Pokemon] = []
    var isLoading = false
    var errorMessage: String?

    func loadPokemon() async {
        isLoading = true
        errorMessage = nil

        do {
            // Load Pokemon 1-151 sequentially
            for id in 1...151 {
                let url = URL(
                    string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let pokemonData = try JSONDecoder().decode(
                    Pokemon.self, from: data)
                pokemon.append(pokemonData)
            }
        } catch {
            errorMessage =
                "Failed to load Pokemon: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
