//
//  FactsStore.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct FactsStore {
    
    let networkService = NetworkService()

    //MARK: - State
    @ObservableState
    struct State: Equatable {
        let animalCategory: AnimalEntity
        
        var selectionIndex = 0
        
        init(animalCategory: AnimalEntity) {
            self.animalCategory = animalCategory
        }
    }
    
    //MARK: - Action
    enum Action: BindableAction {
        case previusButtonTapped
        case nextButtonTapped
        case binding(BindingAction<State>)
    }
    
    //MARK: - Reducer
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .previusButtonTapped:
                state.selectionIndex = state.selectionIndex - 1
                return .none
            case .nextButtonTapped:
                state.selectionIndex += 1
                
                return .none
            case .binding(_):
                return .none
            }
        }
        
    }
}
