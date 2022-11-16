//
//  NimbleSurveyApp.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 27/09/2022.
//

import Login
import Splash
import Styleguide
import SurveyClient
import SwiftUI
import Validator

@main
struct NimbleSurveyApp: App {

    @State private var finishLaunching = false

    private var surveyClient: SurveyClient = {
        #if STAGING
        SurveyClient(
            environment: .test,
            clientId: clientId,
            clientSecret: clientSecret
        )
        #elseif PRODUCTION
        SurveyClient(
            environment: .live,
            clientId: clientId,
            clientSecret: clientSecret
        )
        #endif
    }()

    init() {
        Styleguide.registerFonts()
        UITextField.appearance().keyboardAppearance = .dark
    }

    var body: some Scene {
        WindowGroup {
            VStack {
                if finishLaunching {
                    LoginView(
                        viewModel: LoginViewModel(
                            surveyClient: surveyClient,
                            validator: Validator()
                        )
                    )
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
}
