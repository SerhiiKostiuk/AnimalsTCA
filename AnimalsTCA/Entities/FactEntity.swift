//
//  FactEntity.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation
import SwiftUI

struct FactEntity {
    let fact: String
    let imageUrl: String?
    let id: UUID
}

extension FactEntity: Equatable {
    static func == (lhs: FactEntity, rhs: FactEntity) -> Bool {
        lhs.id == rhs.id
    }
}

extension FactEntity {
    var asFactRealmEntity: FactRealmEntity {
        .init(id: self.id,
              fact: self.fact,
              imageUrl: self.imageUrl)
    }
}
