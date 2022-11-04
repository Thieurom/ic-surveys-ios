//
//  View+Placeholder.swift
//  Styleguide
//
//  Created by Doan Thieu on 25/10/2022.
//

import SwiftUI

extension View {

    public func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
