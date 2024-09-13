//
//  AnimalCategoriesView.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct AnimalCategoriesView: View {
    // MARK: - Private
    @Perception.Bindable private var store: StoreOf<AnimalCategoriesStore>
    
    @State private var category: AnimalEntity?
    
    // MARK: - Initialization
    init(store: StoreOf<AnimalCategoriesStore>) {
        self.store = store
    }
    
    // MARK: - Body
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path,
                                               action: \.categoryDetails )) {
                GeometryReader(content: { geometry in
                    ScrollView(.vertical) {
                        LazyVStack(spacing: Constants.spacingM, content: {
                            if let animalsCategories = store.animalsCategories {
                                ForEach(animalsCategories, id: \.order) { category in
                                    Group {
                                        
                                        switch category.status {
                                        case .paid:
                                            Button {
                                                store.send(.didShowAddsAlertFor(category))
                                            } label: {
                                                CategoryCellView(category: category)
                                            }
                                            
                                        case .comingSoon:
                                            Button {
                                                store.send(.didShowCommingSoonAlert(category.order))
                                            } label: {
                                                CategoryCellView(category: category)
                                            }
                                        default:
                                            
                                            NavigationLink(state: FactsStore.State(animalCategory: category)) {
                                                CategoryCellView(category: category)
                                            }
                                        }
                                    }
                                    .frame(height: geometry.size.width / Constants.divider)
                                }
                            } else {
                                ForEach(0...2, id: \.self) { _ in
                                    CategoryCellView(category: AnimalEntity.empty)
                                        .redacted(reason: .placeholder)
                                }
                                .frame(height: geometry.size.width / Constants.divider)
                            }
                        })
                    }
                })
                .padding(.horizontal, Constants.spacingS)
                .background {
                    Constants.backgroundColor.ignoresSafeArea()
                }
            } destination: { store in
                FactsView(store: store)
            }
            
            .onAppear {
                store.send(.start)
            }
            .alert($store.scope(state: \.addsAlert, action: \.addsAlert))
            .overlay(content: {
                if store.showAdds {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(Constants.opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.delay) {
                            store.send(.addsShowed)
                        }
                    }
                }
            })
            .alert($store.scope(state: \.commingSoonAlert, action: \.commingSoonAlert))
        }
    }
}

// MARK: - Constants

private extension AnimalCategoriesView {
    
    enum Constants {
        static let paidTitleColor = Color(red: 0.031, green: 0.227, blue: 0.921, opacity: 1)
        static let backgroundColor = Color(red: 0.577, green: 0.358, blue: 0.749)
        static let opacity = 0.5
        static let delay = 2.0
        static let divider = 3.0
        static let spacingS = 16.0
        static let spacingM = 20.0
    }
}

#Preview {
    AnimalCategoriesView(store: .init(initialState: AnimalCategoriesStore.State(), reducer: {
        AnimalCategoriesStore()
    }))
}
