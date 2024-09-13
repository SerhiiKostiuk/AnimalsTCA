//
//  FactsView.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

struct FactsView: View {
    // MARK: - @Environment
    @Environment(\.dismiss) var popAction
        
    // MARK: - Private
    @Perception.Bindable private var store: StoreOf<FactsStore>
    
    private var facts: [FactEntity] {
        store.animalCategory.facts ?? []
    }
    
    // MARK: - Initialization
    init(store: StoreOf<FactsStore>) {
        self.store = store
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader { proxy in
            WithPerceptionTracking {
                VStack(spacing: Constants.spacingS, content: {
                    topView
                    
                    contentView
                        .padding(.bottom, Constants.spacingM)
                        .padding(.top, Constants.spacingS)
                })
            }
        }
        .background(
            Constants.backgroundColor.ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }
    
    // MARK: - Private Views
    private var topView: some View {
        ZStack(alignment: .center) {
            HStack(spacing: Constants.spacingXXS) {
                backButton
                    
                Spacer()

                let selectedFact = facts[store.selectionIndex]
                
                ShareLink(item: selectedFact.fact)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, Constants.spacingXXS)
            }
            .background(Constants.backgroundColor.shadow(color: Constants.navigationBarShadowColor, radius: 1, x: 0, y: 4))
            
            Text(store.animalCategory.title)
                .font(.system(size: Constants.fontSize))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var backButton: some View {
        Button {
            popAction()
        } label: {
            HStack {
                Image(Constants.navigationBackImageName)
                    .resizable()
                    .frame(width: Constants.backImageHeight,
                           height: Constants.backImageHeight)
            }
            .frame(width: Constants.backButtonHeight, height: Constants.backButtonHeight)
        }
    }
    
    private var contentView: some View {
        VStack(spacing: Constants.spacingM) {
            factsTabView
            
            buttonView
        }
        .padding(.horizontal, Constants.spacingXS)
    }
    
    private var factsTabView: some View {
        GeometryReader { proxy in
            WithPerceptionTracking {
                TabView(selection: $store.selectionIndex) {
                    ForEach(0..<facts.count , id: \.self) { index in
                        WithPerceptionTracking {
                            let fact = facts[index]
                            
                            FactsCardView(fact: fact)
                                .frame(height: proxy.size.height)
                                .background {
                                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                        .fill(.white)
                                }
                                .id(index)
                                .scaleEffect(store.selectionIndex == index ? 1 : 0.9)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .shadow(color: Constants.navigationBarShadowColor, radius: 4, x: 5, y: 5)
    }
        
    private var buttonView: some View {
        HStack {
            Button {
                store.send(.previusButtonTapped, animation: .easeInOut(duration: Constants.animationDuration))
            } label: {
                Image(Constants.backImageName)
            }
            .buttonStyle(IconButtonStyle(isDisabled: store.selectionIndex == .zero))
            .disabled(store.selectionIndex == .zero)
            
            Spacer()
            
            Button {
                store.send(.nextButtonTapped, animation: .easeInOut(duration: Constants.animationDuration))
            } label: {
                Image(Constants.nexyImageName)
            }
            .buttonStyle(IconButtonStyle(isDisabled: store.selectionIndex == facts.count - 1))
            .disabled(store.selectionIndex == facts.count - 1)
        }
        .padding(.horizontal, Constants.spacingXS)
        .padding(.bottom, Constants.spacingXS)
    }
}

// MARK: - Constants
private extension FactsView {
    
    enum Constants {
        static let backgroundColor = Color(red: 0.577, green: 0.358, blue: 0.749)
        static let navigationBarShadowColor = Color.black.opacity(0.25)
        static let navigationBackImageName = "navigate_back"
        static let cornerRadius: CGFloat = 6
        static let spacingXXS: CGFloat = 10
        static let spacingXS: CGFloat = 20
        static let spacingS: CGFloat = 30
        static let spacingM: CGFloat = 50
        static let spacingL: CGFloat = 60
        static let animationDuration: CGFloat = 0.2
        static let fontSize: CGFloat = 17
        static let backImageHeight: CGFloat = 16
        static let backButtonHeight: CGFloat = 40
        static let backImageName = "back"
        static let nexyImageName = "next"

    }
}

#Preview {
    FactsView(
        store: .init(
            initialState: FactsStore.State(
                animalCategory: .init(
                    title: "Cats",
                    description: "some descrip text",
                    imageUrl: "https://images6.alphacoders.com/337/337780.jpg",
                    status: .paid,
                    order: 2,
                    facts: [
                        FactEntity(
                            fact: "Purring does not always indicate that a cat is happy and healthy - some cats will purr loudly when they are terrified or in pain.",
                            imageUrl: "https://cdn2.thecatapi.com/images/blm.jpg",
                            id: UUID()
                        ),
                        
                        FactEntity(
                            fact: "The term “puss” is the root of the principal word for “cat” in the Romanian term pisica and the root of secondary words in Lithuanian (puz) and Low German puus. Some scholars suggest that “puss” could be imitative of the hissing sound used to get a cat’s attention. As a slang word for the female pudenda, it could be associated with the connotation of a cat being soft, warm, and fuzzy. The term “puss” is the root of the principal word for “cat” in the Romanian term pisica and the root of secondary words in Lithuanian (puz) and Low German puus. Some scholars suggest that “puss” could be imitative of the hissing sound used to get a cat’s attention. As a slang word for the female pudenda, it could be associated with the connotation of a cat being soft, warm, and fuzzy.",
                            imageUrl: "https://cdn2.thecatapi.com/images/dmk.jpg",
                            id: UUID()
                        ),
                        FactEntity(
                            fact: "The silks created by weavers in Baghdad were inspired by the beautiful and varied colors and markings of cat coats. These fabrics were called 'tabby' by European traders.",
                            imageUrl: "https://cdn2.thecatapi.com/images/9qr.png",
                            id: UUID()
                        )
                    ]
                )
            ),
            reducer: {
                FactsStore()
            }
        )
    )
}
