//
//  SurveyClientType.swift
//
//
//  Created by Doan Thieu on 13/10/2022.
//

import Combine

public protocol SurveyClientType {

    func authenticate(email: String, password: String) -> AnyPublisher<Credentials, SurveyError>
}
