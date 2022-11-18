//
//  View+Spinner.swift
//  Styleguide
//
//  Created by Doan Thieu on 11/11/2022.
//

import SwiftUI

struct Spinner: ViewModifier {

    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                ProgressView(value: 0.6)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2.0)
                    .renderedIf(isPresented)
            )
            .disabled(isPresented)
    }
}

extension View {

    public func spinner(isPresented: Binding<Bool>) -> some View {
        modifier(Spinner(isPresented: isPresented))
    }
}
