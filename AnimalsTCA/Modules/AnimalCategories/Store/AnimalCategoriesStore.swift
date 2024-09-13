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
    
    @ObservableState
    struct State: Equatable {
        @Presents var addsAlert: AlertState<Action.AddsAlert>?
        @Presents var commingSoonAlert: AlertState<Action.CommingSoonAlert>?
        
        var animalsCategories: [AnimalEntity]?
        var isLoading: Bool = false
        var path = StackState<FactsStore.State>()
        var showAdds: Bool = false
        var addsShowed: Bool = false
        var paidCategory: AnimalEntity?
    }
    
    enum Action: Equatable {
        case start
        case categoryDetails(StackAction<FactsStore.State, FactsStore.Action>)
        case animalsResponse([AnimalEntity]?)
        case addsAlert(PresentationAction<AddsAlert>)
        case didShowAddsAlertFor(AnimalEntity)
        case commingSoonAlert(PresentationAction<CommingSoonAlert>)
        case didShowCommingSoonAlert(Int)
        case addsShowed
        
        @CasePathable
        enum AddsAlert {
            case showAdds
        }
        
        @CasePathable
        enum CommingSoonAlert {
            case ok
        }
    }
    
    // MARK: - Body
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .start:
                state.isLoading = true
                return .run { send in
                    let result = try? await enviroment.networkService.request(AnimalsRequest.animalsCategories,
                                                                              [AnimalAPIModel].self)
                    let animalCategories = try result?.entities().sorted(by: { $0.order < $1.order })
                    await send(.animalsResponse(animalCategories))
                }
                
            case let .animalsResponse(animalEntites):
                state.isLoading = false
                state.animalsCategories = animalEntites
                return .none
                
            case .categoryDetails:
                return .none
                
            case .addsAlert(.presented(.showAdds)):
                state.showAdds = true
                return .none
                
            case .addsAlert(.dismiss):
                state.showAdds = false
                return .none
                
            case let .didShowAddsAlertFor(entity):
                state.paidCategory = entity
                
                state.addsAlert = AlertState(title: {
                    TextState("Watch Ad to continue")
                }, actions: {
                    ButtonState(action: .showAdds) {
                        TextState("Show Ad")

                    }
                    ButtonState {
                        TextState("Cancel")
                    }
                })
                
                return .none
                
            case .commingSoonAlert(.presented(.ok)),
                    .commingSoonAlert(.dismiss):
                state.commingSoonAlert = nil
                return .none
                
            case let .didShowCommingSoonAlert(order):
                guard let category = state.animalsCategories?.first(where: { $0.order == order }) else {
                    
                    return .none
                }
                
                state.commingSoonAlert = AlertState(title: {
                    TextState(category.title)
                }, actions: {
                    ButtonState {
                        TextState("Ok")
                    }
                })
              
                return .none
                
            case .addsShowed:
                state.addsShowed.toggle()
                state.showAdds.toggle()
                
                guard let paidCategory = state.paidCategory else {
                    return .none
                }
                state.path.append(FactsStore.State(animalCategory: paidCategory))

                return .none
            }
        
        }
        .forEach(\.path, action: \.categoryDetails) {
            FactsStore()
        }
        .ifLet(\.$addsAlert, action: \.addsAlert)
        .ifLet(\.$commingSoonAlert, action: \.commingSoonAlert)
    }
}
