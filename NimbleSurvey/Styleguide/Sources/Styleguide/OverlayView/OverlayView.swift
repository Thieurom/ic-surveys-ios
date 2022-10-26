//
//  OverlayView.swift
//  Styleguide
//
//  Created by Doan Thieu on 28/09/2022.
//

import SwiftUI

public struct OverlayView: View {

    public var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black.opacity(0.01), .black.opacity(0.8)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    public init() {}
}

struct OverlayView_Previews: PreviewProvider {

    static var previews: some View {
        OverlayView()
    }
}
