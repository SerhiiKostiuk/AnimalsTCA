//
//  FactsCardView.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 13.09.2024.
//

import SwiftUI
import Kingfisher

struct FactsCardView: View {
    
    // MARK: - Private
    private let fact: FactEntity
    
    // MARK: - Initialization
    init(fact: FactEntity) {
        self.fact = fact
    }
    
    // MARK: - Body
    var body: some View {
        GeometryReader(content: { geometry in
            VStack(alignment: .center, spacing: Constants.spacingXS, content: {
                KFImage(URL(string: fact.imageUrl ?? .empty))
                    .fade(duration: Constants.animationDuration)
                    .placeholder {
                        Image(Constants.placeholderImageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.width * Constants.divider)
                            .clipped()
                            .clipShape(Rectangle())
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width,
                           height: geometry.size.width * Constants.divider)
                    .clipped()
                    .clipShape(Rectangle())
                
                ScrollView {
                    Text(fact.fact)
                        .padding(.horizontal, Constants.spacingXS)
                        .font(.system(size: Constants.fontSize))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
            })
        })
        .padding(.all, Constants.spacingXXS)
    }
}

// MARK: - Constants
private extension FactsCardView {
    
    enum Constants {
        static let placeholderImageName = "placeholder_image"
        static let backgroundColor = Color(red: 0.577, green: 0.358, blue: 0.749)
        static let navigationBarShadowColor = Color.black.opacity(0.25)
        static let cornerRadius: CGFloat = 6
        static let spacingXXS: CGFloat = 10
        static let spacingXS: CGFloat = 20
        static let animationDuration: CGFloat = 0.25
        static let fontSize: CGFloat = 17
        static let backImageHeight: CGFloat = 16
        static let divider: CGFloat = 3/4
    }
}
