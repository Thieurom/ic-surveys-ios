//
//  SplashView.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 28/09/2022.
//

import Styleguide
import SwiftUI

public struct SplashView: View {

    @State private var showingLogo = false

    public var body: some View {
        ZStack {
            Asset.Images.background.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(OverlayView())
                .ignoresSafeArea()

            Asset.Images.logo.swiftUIImage
                .frame(maxWidth: .infinity)
                .opacity(showingLogo ? 1.0 : 0.0)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1.0).delay(1.0)) {
                showingLogo = true
            }
        }
    }

    public init() {}
}

#if DEBUG
struct SplashView_Previews: PreviewProvider {

    static var previews: some View {
        SplashView()
    }
}
#endif
