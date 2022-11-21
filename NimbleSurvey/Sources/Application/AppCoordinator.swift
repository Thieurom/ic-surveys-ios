//
//  AppCoordinator.swift
//  NimbleSurvey
//
//  Created by Doan Thieu on 21/11/2022.
//

import Combine
import Login
import Splash
import SwiftUI

final class AppCoordinator: ObservableObject {

    // Initial state
    @Published var state: AppState = .splash(SplashState())

    private var cancellables = Set<AnyCancellable>()

    init() {
        $state
            .compactMap { currentState -> SplashState? in
                if case let .splash(splashState) = currentState {
                    return splashState
                }
                return nil
            }
            .flatMap(\.$isFinishLoading)
            .filter { $0 }
            .sink(receiveValue: { [weak self] _ in
                self?.state = .login(LoginState())
            })
            .store(in: &cancellables)

        $state
            .compactMap { currentState -> LoginState? in
                if case let .login(loginState) = currentState {
                    return loginState
                }
                return nil
            }
            .flatMap(\.$isLoginSuccessfully)
            .filter { $0 }
            .sink(receiveValue: { [weak self] _ in
                self?.state = .home
            })
            .store(in: &cancellables)
    }
}
