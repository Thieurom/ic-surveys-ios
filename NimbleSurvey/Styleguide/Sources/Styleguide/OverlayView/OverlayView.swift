//
//  OverlayView.swift
//  Styleguide
//
//  Created by Doan Thieu on 28/09/2022.
//

import SwiftUI

public struct OverlayView: View {

    let colors: [Color]

    public var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    public init(colors: [Color] = [.black.opacity(0.01), .black.opacity(0.8)]) {
        self.colors = colors
    }
}

struct OverlayView_Previews: PreviewProvider {

    static var previews: some View {
        OverlayView()
    }
}
