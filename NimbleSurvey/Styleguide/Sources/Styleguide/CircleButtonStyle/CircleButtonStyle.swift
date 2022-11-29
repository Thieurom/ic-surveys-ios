//
//  CircleButtonStyle.swift
//  Styleguide
//
//  Created by Doan Thieu on 22/11/2022.
//

import SwiftUI

public struct CircleButtonStyle: ButtonStyle {

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 56.0, height: 56.0)
            .background(Color.white)
            .cornerRadius(.infinity)
    }
}
