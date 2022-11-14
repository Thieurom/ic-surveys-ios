//
//  MockSurveyClient.swift
//  LoginTests
//
//  Created by Doan Thieu on 14/11/2022.
//

import Combine
import SurveyClientType

class MockSurveyClient: SurveyClientType {

    var authenticateResult: AnyPublisher<Credentials, SurveyError>!

    func authenticate(email: String, password: String) -> AnyPublisher<Credentials, SurveyError> {
        return authenticateResult
    }
}
