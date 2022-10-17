// swiftlint:disable:this file_name
//
//  ApiEnvironment.swift
//  SurveyClient
//
//  Created by Doan Thieu on 15/10/2022.
//

import Foundation

var apiEnvironment: Environment = .live

extension Environment {

    // swiftlint:disable force_unwrapping
    var endpoint: URL {
        switch self {
        case .test: return URL(string: "https://nimble-survey-web-staging.herokuapp.com/api/v1")!
        case .live: return URL(string: "https://survey-api.nimblehq.co/api/v1/")!
        }
    }
}
