//
//  PrimaryButtonStyle.swift
//  Styleguide
//
//  Created by Doan Thieu on 21/11/2022.
//

import SwiftUI

public struct PrimaryButtonStyle: ButtonStyle {

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .adaptiveFont(.neuzeitHeavy, size: 17.0)
            .frame(height: 56.0)
            .padding(.horizontal, 20.0)
            .background(Color.white)
            .cornerRadius(10.0)
            .foregroundColor(.black)
    }
}
