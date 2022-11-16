//
//  Validator.swift
//  DataValidation
//
//  Created by Doan Thieu on 16/11/2022.
//

import Foundation
import Validating

public struct Validator: Validating {

    public init() {}

    private static let emailPattern = "^([a-zA-Z0-9][\\w\\.\\+\\-]*)@([\\w.\\-]+\\.+[\\w]{2,})$"

    public func validate(email: String) -> Bool {
        return validate(email, pattern: Self.emailPattern)
    }

    public func validate(password: String) -> Bool {
        return password.count >= 8
    }
}

extension Validator {

    private func validate(_ string: String, pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(string.startIndex ..< string.endIndex, in: string)
            let matchingOptions = NSRegularExpression.MatchingOptions(rawValue: 0)

            return regex.firstMatch(in: string, options: matchingOptions, range: range) != nil
        } catch {
            return false
        }
    }
}

