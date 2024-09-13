//
//  AnimalRealmEntity.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 13.09.2024.
//

import Foundation
import RealmSwift

final class AnimalRealmEntity: Object {
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var animalDescription: String
    @Persisted var imageUrl: String
    @Persisted var status: ContentStatus
    @Persisted var order: Int
    @Persisted var facts: List<FactRealmEntity>
    
    convenience init(title: String, animalDescription: String, imageUrl: String, status: ContentStatus, order: Int, facts: List<FactRealmEntity>) {
        self.init()
        self.id = UUID()
        self.title = title
        self.animalDescription = animalDescription
        self.imageUrl = imageUrl
        self.status = status
        self.order = order
        self.facts = facts
    }
}

extension AnimalRealmEntity {
    var asAnimalEntity: AnimalEntity {
        .init(title: self.title,
              description: self.animalDescription,
              imageUrl: self.imageUrl,
              status: self.status,
              order: self.order,
              facts: self.facts.map({ $0.asFactEntity }))
    }
}
