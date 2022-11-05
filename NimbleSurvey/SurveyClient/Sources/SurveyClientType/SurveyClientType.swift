//
//  SurveyClientType.swift
//
//
//  Created by Doan Thieu on 13/10/2022.
//

import Combine
import Foundation

public protocol SurveyClientType {

    func authenticate(email: String, password: String) -> AnyPublisher<Credentials, SurveyError>
}

// Provide an `Ok` implementation :), that's it, a client would return successfully
// for every function call without making an actual remote request.
// Might make a companion `SurveyClientFail` later.
// This is useful for previewing SwifUI views or unit testing.
public struct SurveyClientOk: SurveyClientType {

    public init() {}

    public func authenticate(email: String, password: String) -> AnyPublisher<Credentials, SurveyError> {
        return Just(
            Credentials(
                accessToken: "",
                tokenType: "",
                refreshToken: "",
                createdAt: Date(timeIntervalSince1970: 0),
                expiresIn: 0
            )
        )
            .setFailureType(to: SurveyError.self)
            .eraseToAnyPublisher()
    }
}
