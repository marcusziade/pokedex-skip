import SwiftUI

struct ContentView: View {
    let viewModel = PokedexViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding()
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                        ], spacing: 16
                    ) {
                        ForEach(viewModel.pokemon) { pokemon in
                            PokemonCard(pokemon: pokemon)
                                .padding(.horizontal, 8)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Pokedex")
        }
        .task {
            await viewModel.loadPokemon()
        }
    }
}

struct PokemonCard: View {
    let pokemon: Pokemon

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)

            Text(pokemon.name.capitalized)
                .font(.headline)

            HStack {
                ForEach(pokemon.types, id: \.type.name) { typeEntry in
                    Text(typeEntry.type.name)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.accentColor.opacity(0.2)) // Changed from .blue
                        .clipShape(RoundedRectangle(cornerRadius: 20)) // Changed from Capsule
                }
            }

            HStack {
                Text("Height: \(pokemon.height)")
                Text("Weight: \(pokemon.weight)")
            }
            .font(.caption)
            .foregroundColor(.gray) // Changed from .secondary
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

