//
//  AnimalAPIModel.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation
import RealmSwift

struct AnimalAPIModel: Codable {
    let title: String
    let description: String
    let imageUrl: String
    let status: AnimalAPIStatus
    let order: Int
    let facts: [FactAPIModel]?

    let id = UUID().uuidString

    enum CodingKeys: String, CodingKey {
        case title, description, status, order
        case imageUrl = "image"
        case facts = "content"
    }
}

enum AnimalAPIStatus: String, Codable, PersistableEnum {
    case free
    case paid
}
