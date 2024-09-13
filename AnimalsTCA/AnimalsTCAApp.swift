//
//  AnimalsTCAApp.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct AnimalsTCAApp: App {
    private static let store = Store(initialState: AnimalCategoriesStore.State()) {
        AnimalCategoriesStore()
    }
    var body: some Scene {
        WindowGroup {
            WithPerceptionTracking {
                AnimalCategoriesView(store: AnimalsTCAApp.store)
            }
        }
    }
}
