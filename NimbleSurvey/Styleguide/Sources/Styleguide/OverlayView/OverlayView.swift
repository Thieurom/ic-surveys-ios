//
//  OverlayView.swift
//  Styleguide
//
//  Created by Doan Thieu on 28/09/2022.
//

import SwiftUI

public struct OverlayView: View {

    let colors: [Color]

    public init(colors: [Color] = [.black.opacity(0.1), .black.opacity(1.0)]) {
        self.colors = colors
    }

    public var body: some View {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#if DEBUG
struct OverlayView_Previews: PreviewProvider {

    static var previews: some View {
        OverlayView()
    }
}
#endif
