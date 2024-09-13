//
//  Button+Modifiers.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 12.09.2024.
//

import Foundation
import SwiftUI

struct IconButtonStyle: ButtonStyle {
    var isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 52, height: 52)
            .clipShape(Circle())
            .opacity(isDisabled ? 0.1 : 1)
            .background(
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .shadow(color: .black, radius: 4, x: 4, y: 4)
            )
           
    }
}
