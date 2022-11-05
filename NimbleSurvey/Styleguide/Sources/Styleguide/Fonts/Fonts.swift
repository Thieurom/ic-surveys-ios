// swiftlint:disable:this file_name
//
//  Fonts.swift
//  Styleguide
//
//  Created by Doan Thieu on 04/11/2022.
//

import SwiftUI

public typealias FontName = String

extension FontName {

    public static let neuzeitBook = "NeuzeitSLTStd-Book"
    public static let neuzeitHeavy = "NeuzeitSLTStd-BookHeavy"
}

extension View {

    public func adaptiveFont(_ name: FontName, size: CGFloat) -> some View {
        modifier(AdaptiveFont(name: name, size: size))
    }
}

private struct AdaptiveFont: ViewModifier {

    let name: String
    let size: CGFloat

    func body(content: Content) -> some View {
        content.font(.custom(name, size: size))
    }
}
