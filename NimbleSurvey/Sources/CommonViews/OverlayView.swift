//
//  LinearGradientView.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 28/09/2022.
//

import SwiftUI

struct OverlayView: View {

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black.opacity(0.01), .black.opacity(0.8)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct LinearGradientView_Previews: PreviewProvider {

    static var previews: some View {
        OverlayView()
    }
}
