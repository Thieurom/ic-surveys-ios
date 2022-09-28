//
//  SplashView.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 28/09/2022.
//

import SwiftUI

struct SplashView: View {

    @State private var showingLogo = false

    var body: some View {
        ZStack {
            Image(Asset.Images.background.name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .overlay(OverlayView())

            Image(Asset.Images.logo.name)
                .frame(maxWidth: .infinity)
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
