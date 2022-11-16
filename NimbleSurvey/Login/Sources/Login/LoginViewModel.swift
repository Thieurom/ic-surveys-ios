//
//  LoginViewModel.swift
//  Login
//
//  Created by Doan Thieu on 04/11/2022.
//

import Combine
import SwiftUI
import SurveyClientType

public class LoginViewModel: ObservableObject {

    // MARK: - Public

    @Published var email = ""
    @Published var password = ""
    @Published private(set) var isLoginEnabled = false
    @Published private(set) var isLoading = false
    @Published private(set) var loginResult: (title: String, description: String)?

    // MARK: - Internal

    private var cancellables = Set<AnyCancellable>()
    private let surveyClient: SurveyClientType

    public init(surveyClient: SurveyClientType) {
        self.surveyClient = surveyClient

        Publishers.CombineLatest($email, $password)
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .assign(to: &$isLoginEnabled)
    }
    
    public func login() {
        guard isLoginEnabled else { return }

        isLoading = true

        surveyClient.authenticate(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    self?.loginResult = ("Unable to login", "There's something wrong. Please try again!")
                }
            }, receiveValue: { [weak self] _ in
                // TODO: Navigate to the Home screen
                self?.loginResult = ("Login successfully", "You've been logged in!")
            })
            .store(in: &cancellables)
    }
}
