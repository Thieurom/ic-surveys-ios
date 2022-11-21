//
//  NimbleSurveyApp.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 27/09/2022.
//

import Home
import Login
import Splash
import Styleguide
import SurveyClient
import SwiftUI
import Validator

@main
struct NimbleSurveyApp: App {

    @StateObject var appCoordinator = AppCoordinator()

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
                switch appCoordinator.state {
                case let .splash(splashState):
                    SplashView()
                        .environmentObject(splashState)
                case let .login(loginState):
                    LoginView(
                        viewModel: LoginViewModel(
                            surveyClient: surveyClient,
                            validator: Validator()
                        )
                    )
                    .environmentObject(loginState)
                case .home:
                    HomeView()
                }
            }
        }
    }
}
