//
//  SurveyApiRoute.swift
//  SurveyClient
//
//  Created by Doan Thieu on 13/10/2022.
//

import Foundation

enum SurveyApiRoute: Equatable {

    case authenticate(email: String, password: String, clientId: String, clientSecret: String)
}

extension SurveyApiRoute: Route {

    var url: URL {
        apiEnvironment.endpoint.appendingPathComponent(path)
    }

    var path: String {
        switch self {
        case .authenticate: return "oauth/token"
        }
    }

    var method: HttpMethod {
        switch self {
        case .authenticate: return .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .authenticate(email, password, clientId, clientSecret):
            return [
                "grant_type": "password",
                "email": email,
                "password": password,
                "client_id": clientId,
                "client_secret": clientSecret
            ]
        }
    }

    var parameterEncoding: ParameterEncoding? {
        switch self {
        case .authenticate: return .json
        }
    }
}

extension SurveyApiRoute: URLRequestConvertible {

    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        guard let parameters = parameters, let parameterEncoding = parameterEncoding else {
            return request
        }

        switch parameterEncoding {
        case .json:
            if let data = try? JSONSerialization.data(withJSONObject: parameters) {
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                request.httpBody = data
            }
        case .url:
            var urlComponents = URLComponents()
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
        }

        return request
    }
}
