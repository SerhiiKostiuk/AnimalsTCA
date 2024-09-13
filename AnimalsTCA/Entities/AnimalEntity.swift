//
//  AnimalEntity.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation

struct AnimalEntity {
    let title: String
    let description: String
    let imageUrl: String
    let status: ContentStatus
    let order: Int
    let facts: [FactEntity]?
    
    enum ContentStatus {
        case free
        case paid
        case comingSoon
    }
}

extension AnimalEntity: Equatable {
    static func == (lhs: AnimalEntity, rhs: AnimalEntity) -> Bool {
        lhs.order == rhs.order
    }
}

extension AnimalEntity {
    
    static var empty: AnimalEntity {
        return .init(title: "empty",
                     description: "empty",
                     imageUrl: .empty,
                     status: .paid,
                     order: 0,
                     facts: .none)
    }
}
