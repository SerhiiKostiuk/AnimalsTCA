//
//  Collection+Extensions.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation

extension Collection where Element: EntitySerialization {
    
    func mapEntities() throws -> [Element.Entity] {
        try self.map { try $0.entity() }
    }
}
