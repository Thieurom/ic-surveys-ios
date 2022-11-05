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
}
