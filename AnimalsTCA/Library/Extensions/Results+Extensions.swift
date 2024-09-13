//
//  Results+Extensions.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 13.09.2024.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        compactMap { $0 }
    }
}
