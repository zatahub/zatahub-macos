//
//  MacButtonStyles.swift
//  ZataHub
//
//  Created by Macbook on 26/01/2024.
//

import SwiftUI

struct MacButtonStyles: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.clear : Color.white)
            .background(configuration.isPressed ? Color.white : Color.clear)
            .cornerRadius(5.0)
            .frame(maxHeight: .infinity)
            .padding(.horizontal)
            .padding(.vertical)

    }

}
