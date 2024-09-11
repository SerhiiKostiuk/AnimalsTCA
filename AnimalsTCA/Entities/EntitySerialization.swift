//
//  EntitySerialization.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation

protocol EntitySerialization {
    
    associatedtype Entity

    func entity() throws -> Entity
}

extension Array where Element: EntitySerialization {

    func entities() throws -> [Element.Entity] {
        try self.map { try $0.entity() }
    }
}

extension Set where Element: EntitySerialization {
    
    func entities() throws -> [Element.Entity] {
        try self.map { try $0.entity() }
    }
}
