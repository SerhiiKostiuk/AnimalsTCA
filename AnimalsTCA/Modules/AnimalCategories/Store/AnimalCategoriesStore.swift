//
//  AnimalCategoriesStore.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalCategoriesStore {
    
    private let enviroment: AnimalCategoriesEnviroment = .init(networkService: NetworkService())
    
    struct State: Equatable {
        var animalsCategories: [AnimalEntity]?
        var isLoading: Bool = false
        var path = StackState<FactsStore.State>()
    }
    
    enum Action: Equatable {
        case start
        case categoryDetails(StackAction<FactsStore.State, FactsStore.Action>)
        case animalsResponse([AnimalEntity]?)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .start:
                return .run { send in
                    let result = try? await enviroment.networkService.request(AnimalsRequest.animalsCategories,
                                                                              [AnimalAPIModel].self)
                    let animalCategories = try result?.entities()
                    await send(.animalsResponse(animalCategories))
                }
            case let .animalsResponse(animalEntites):
                state.isLoading = false
                state.animalsCategories = animalEntites
                return .none
            case let .categoryDetails(animalEntity):
                return .none
            }
        }
        .forEach(\.path, action: \.categoryDetails) {
            FactsStore()
        }
    }
}
