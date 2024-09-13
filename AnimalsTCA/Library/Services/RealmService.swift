//
//  RealmService.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 13.09.2024.
//

import Foundation
import RealmSwift

final class RealmService {
    //MARK: - Public Func

    func save<T: Object>(_ object: T, update: Bool = false) async throws {
        let realm = try await Realm()
        
        try await realm.asyncWrite {
            realm.add(object, update: update ? .modified : .all)
        }
    }
    
    func save<T: Object>(_ objects: [T], update: Bool = false) async throws {
        let realm = try await Realm()
        
        try await realm.asyncWrite {
            realm.add(objects, update: update ? .modified : .all)
        }
    }
    
    func getObjects<T: Object>(ofType type: T.Type) -> Results<T>? {
        let realm = try? Realm()

        return realm?.objects(type)
    }
}
