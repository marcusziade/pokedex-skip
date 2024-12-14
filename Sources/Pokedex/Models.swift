import Foundation
import Observation

@Observable
class Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [TypeEntry]

    init(
        id: Int, name: String, height: Int, weight: Int, sprites: Sprites,
        types: [TypeEntry]
    ) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.sprites = sprites
        self.types = types
    }

    struct Sprites: Codable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct TypeEntry: Codable {
        let type: PokemonType
    }

    struct PokemonType: Codable {
        let name: String
    }
}
