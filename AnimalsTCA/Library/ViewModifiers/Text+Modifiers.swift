//
//  Text+Modifiers.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import SwiftUI

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundColor(.black)
    }
}

struct DescriptionTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12))
            .foregroundColor(.black.opacity(0.5))
            .multilineTextAlignment(.leading)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleTextStyle())
    }
    
    func descriptionStyle() -> some View {
        self.modifier(DescriptionTextStyle())
    }
}

#Preview {
    VStack {
        Text("titleStyle").titleStyle()
        Text("descriptionStyle").descriptionStyle()
    }
}
