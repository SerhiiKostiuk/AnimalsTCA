//
//  FactRealmEntity.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 13.09.2024.
//

import Foundation
import RealmSwift

final class FactRealmEntity: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var fact: String
    @Persisted var imageUrl: String?
    
   convenience init(id: UUID, fact: String, imageUrl: String? = nil) {
        self.init()
        self.id = id
        self.fact = fact
        self.imageUrl = imageUrl
    }
}

extension FactRealmEntity {
    var asFactEntity: FactEntity {
        .init(fact: self.fact,
              imageUrl: self.imageUrl,
              id: self.id)
    }
}
