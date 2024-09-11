//
//  FactAPIModel.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation

struct FactAPIModel: Codable {
    let fact: String
    let imageUrl: String
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case fact
        case imageUrl = "image"
    }
}

extension FactAPIModel: EntitySerialization {
    typealias Entity = FactEntity
    
    func entity() throws -> FactEntity {
        .init(fact: fact, imageUrl: imageUrl, id: id)
    }
}
