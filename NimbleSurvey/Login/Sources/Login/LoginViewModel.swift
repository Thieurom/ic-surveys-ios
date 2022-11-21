//
//  LoginViewModel.swift
//  Login
//
//  Created by Doan Thieu on 04/11/2022.
//

import Combine
import SwiftUI
import SurveyClientType
import Validating

public class LoginViewModel: ObservableObject {

    // MARK: - Public

    @Published var email = ""
    @Published var password = ""
    // This is quite a hack, since we don't want to show validation errors
    // when the users haven't input anything yet!
    @Published private(set) var isEmailValid = true
    @Published private(set) var isPasswordValid = true
    @Published private(set) var isLoginEnabled = false
    @Published private(set) var isLoading = false
    @Published private(set) var isLoginSuccessfully = false

    // MARK: - Internal

    private var cancellables = Set<AnyCancellable>()
    private let surveyClient: SurveyClientType
    private let validator: Validating

    public init(surveyClient: SurveyClientType, validator: Validating) {
        self.surveyClient = surveyClient
        self.validator = validator

        Publishers.CombineLatest($email, $password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .assign(to: &$isLoginEnabled)
    }
    
    public func login() {
        guard isLoginEnabled && validateFields() else { return }

        isLoading = true

        surveyClient.authenticate(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    self?.isLoginSuccessfully = false
                }
            }, receiveValue: { [weak self] _ in
                self?.isLoginSuccessfully = true
            })
            .store(in: &cancellables)
    }
}

extension LoginViewModel {

    private func validateFields() -> Bool {
        isEmailValid = validator.validate(email: email)
        isPasswordValid = validator.validate(password: password)
        return isEmailValid && isPasswordValid
    }
}
