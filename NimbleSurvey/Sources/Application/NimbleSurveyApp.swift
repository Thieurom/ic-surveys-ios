//
//  NimbleSurveyApp.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 27/09/2022.
//

import Login
import Splash
import Styleguide
import SwiftUI

@main
struct NimbleSurveyApp: App {

    @State private var finishLaunching = false

    var body: some Scene {
        WindowGroup {
            VStack {
                if finishLaunching {
                    LoginView()
                } else {
                    SplashView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    finishLaunching = true
                }
            }
        }
    }

    init() {
        Styleguide.registerFonts()
        UITextField.appearance().keyboardAppearance = .dark
    }
}
