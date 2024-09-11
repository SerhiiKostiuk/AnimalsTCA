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

extension AnimalAPIModel: EntitySerialization {
    typealias Entity = AnimalEntity
    
    func entity() throws -> AnimalEntity {
        var contentStatus: AnimalEntity.ContentStatus
        
        if facts == nil || facts?.count == 0 {
            contentStatus = .comingSoon
        } else {
            switch status {
            case .free: contentStatus = .free
            case .paid: contentStatus = .paid
            }
        }
        
        let facts = try? facts?.mapEntities()
        return .init(title: title,
                     description: description,
                     imageUrl: imageUrl,
                     status: contentStatus,
                     order: order,
                     facts: facts)
    }
}
