//
//  AppState.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 21/11/2022.
//

import Login
import Splash

enum AppState {

    case splash(SplashState)
    case login(LoginState)
    case home
}
