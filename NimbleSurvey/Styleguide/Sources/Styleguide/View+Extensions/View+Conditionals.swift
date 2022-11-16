//
//  View+Conditionals.swift
//  Styleguide
//
//  Created by Doan Thieu on 11/11/2022.
//

import SwiftUI

extension View {

    public func renderedIf(_ condition: Bool) -> Self? {
        guard condition else {
            return nil
        }

        return self
    }

    public func hiddenIf(_ condition: Bool) -> some View {
        return self.opacity(condition ? 0.0 : 1.0)
    }
}
