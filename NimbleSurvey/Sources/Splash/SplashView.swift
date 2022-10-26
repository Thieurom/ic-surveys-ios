//
//  SplashView.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 28/09/2022.
//

import Styleguide
import SwiftUI

struct SplashView: View {

    @State private var showingLogo = false

    var body: some View {
        ZStack {
            Asset.Images.background.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .overlay(OverlayView())

            Asset.Images.logo.swiftUIImage
                .frame(maxWidth: .infinity)
                .opacity(showingLogo ? 1.0 : 0.0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
                showingLogo = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {

    static var previews: some View {
        SplashView()
    }
}
