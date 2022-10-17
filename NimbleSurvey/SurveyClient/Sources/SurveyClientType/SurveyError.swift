//
//  SurveyError.swift
//
//
//  Created by Doan Thieu on 13/10/2022.
//

import Foundation

public enum SurveyError: Error {

    case badRequest
    case badData
    case unknown
}

extension SurveyError: CustomDebugStringConvertible {

    public var debugDescription: String {
        switch self {
        case .badRequest: return "Bad request"
        case .badData: return "Bad data"
        case .unknown: return "Unknown error"
        }
    }
}

extension SurveyError: LocalizedError {

    public var errorDescription: String? { debugDescription }
}
