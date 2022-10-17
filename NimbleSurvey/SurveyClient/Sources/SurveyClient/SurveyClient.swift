//
//  SurveyClient.swift
//  SurveyClient
//
//  Created by Doan Thieu on 13/10/2022.
//

import Combine
import Foundation
import JSONAPIMapper
import SurveyClientType

public struct SurveyClient {

    private let clientId: String
    private let clientSecret: String
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder

    public init(
        environment: Environment = .live,
        clientId: String,
        clientSecret: String,
        urlSession: URLSession = .shared,
        jsonDecoder: JSONDecoder = JSONAPIDecoder()
    ) {
        apiEnvironment = environment
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder.dateDecodingStrategy = .secondsSince1970
    }
}

// MARK: - SurveyClient+Environment

extension SurveyClient {

    public var environment: Environment { apiEnvironment }
}

// MARK: - SurveyClientType

extension SurveyClient: SurveyClientType {

    public func authenticate(email: String, password: String) -> AnyPublisher<Credentials, SurveyError> {
        return apiRequest(
            SurveyApiRoute.authenticate(
                email: email,
                password: password,
                clientId: clientId,
                clientSecret: clientSecret
            ),
            for: Credentials.self
        )
    }
}

// MARK: - Make request

extension SurveyClient {

    fileprivate func apiRequest<R: Decodable>(_ urlRequest: URLRequestConvertible, for type: R.Type) -> AnyPublisher<R, SurveyError> {
        let request = urlRequest.asURLRequest()

        #if DEBUG
        print("[SurveyClient][INFO] Request: \(request)\n\(request.allHTTPHeaderFields ?? [:])")
        #endif

        return urlSession.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: {
                #if DEBUG
                let statusCode = ($0.response as? HTTPURLResponse)?.statusCode
                // swiftlint:disable force_unwrapping
                let codeString = statusCode != nil ? "\(statusCode!) " : ""
                print("[SurveyClient][INFO] Response: \(request)\n\(codeString)\(String(decoding: $0.data, as: UTF8.self))")
                #endif
            })
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw SurveyError.unknown
                }

                guard (200..<300) ~= httpResponse.statusCode else {
                    throw SurveyError.badRequest
                }

                return data
            }
            .decode(type: R.self, decoder: jsonDecoder)
            .mapError { error -> SurveyError in
                if error is DecodingError {
                    return .badData
                }

                return (error as? SurveyError) ?? .unknown
            }
            .handleEvents(receiveCompletion: {
                #if DEBUG
                if case let .failure(error) = $0 {
                    print("[SurveyClient][ERROR] Fail: \(error.localizedDescription)")
                }
                #endif
            })
            .eraseToAnyPublisher()
    }
}
