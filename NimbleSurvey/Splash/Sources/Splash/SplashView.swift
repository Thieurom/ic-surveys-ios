//
//  SplashView.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 28/09/2022.
//

import Styleguide
import SwiftUI

public struct SplashView: View {

    @State private var logoOpacity = 0.0
    @EnvironmentObject var splashState: SplashState
    private let animationDuration = 1.0  // second

    public init() {}

    public var body: some View {
        Asset.Images.logo.swiftUIImage
            .frame(maxWidth: .infinity)
            .opacity(logoOpacity)
            .background(
                Asset.Images.background.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(OverlayView())
                    .ignoresSafeArea()
            )
            .onAppear {
                withAnimation(.easeIn(duration: animationDuration).delay(1.0)) {
                    logoOpacity = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(animationDuration))) {
                        splashState.isFinishLoading = true
                    }
                }
            }
    }
}

#if DEBUG
struct SplashView_Previews: PreviewProvider {

    static var previews: some View {
        SplashView()
    }
}
#endif
