//
//  CategoryCellView.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct CategoryCellView: View {
    //MARK: - Private Property
    private let category: AnimalEntity
    
    //MARK: - Initializer
    init(category: AnimalEntity) {
        self.category = category
    }

    //MARK: - Body
    var body: some View {
        GeometryReader(content: { geometry in
            HStack(alignment: .top, spacing: Constants.spacingM) {
                KFImage(URL(string: category.imageUrl))
                    .resizable()
                    .placeholder({
                        Rectangle()
                            .fill(Color.black.opacity(Constants.opacity))
                            .frame(width: geometry.size.height * Constants.imageAspectRatio,
                                   height: geometry.size.height)
                            
                    })
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.height * Constants.imageAspectRatio,
                           height: geometry.size.height)
                    .clipped()
                    .clipShape(Rectangle())
                
                VStack(alignment: .leading, spacing: Constants.spacingXS) {
                    Text(category.title)
                        .titleStyle()
                    
                    Text(category.description)
                        .descriptionStyle()
                        .frame(maxHeight: .infinity, alignment: .top)
                    
                    if category.status == .paid {
                        lockIcon
                    }
                }.padding(.vertical, Constants.spacingS)
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            
        })
        .padding(.all, Constants.spacingS)
        .frame(minHeight: Constants.minHeight, maxHeight: Constants.maxHeight)
        .background(Color.white)
        .overlay {
            if category.status == .comingSoon {
                comingSoonView
            }
        }
        .clipShape(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
        )
    }
    
    //MARK: - Private Views

    private var lockIcon: some View {
        HStack(spacing: Constants.spacingXS) {
            Image(Constants.lockIconName)
            
            Text("Premium")
                .font(.system(size: Constants.fontSize))
        }
        .foregroundStyle(Constants.paidTitleColor)
    }
    
    private var comingSoonView: some View {
        ZStack(alignment: .trailing) {
            Color.black.opacity(Constants.opacity)
            Image(Constants.comingSoonIconName)
        }
    }
}
    
// MARK: - Constants
private extension CategoryCellView {
    enum Constants {
        static let imageAspectRatio: CGFloat = 4/3
        static let paidTitleColor = Color(red: 0.031, green: 0.227, blue: 0.921, opacity: 1)
        static let lockIconName = "lock"
        static let comingSoonIconName = "coming_soon"
        static let cornerRadius = 6.0
        static let spacingXS = 4.0
        static let spacingS = 6.0
        static let spacingM = 20.0
        static let opacity = 0.5
        static let fontSize = 16.0
        static let minHeight = 90.0
        static let maxHeight = 150.0
    }
}

#Preview {
    CategoryCellView(category: .init(title: "Cats", description: "some descrip text", imageUrl: "https://images6.alphacoders.com/337/337780.jpg", status: .paid, order: 2, facts: nil))
}
