//
//  MockValidator.swift
//  
//
//  Created by Doan Thieu on 16/11/2022.
//

public class MockValidator: Validating {

    public init() {}

    public var validateEmail: ((String) -> Bool)?
    public var validatePassword: ((String) -> Bool)?

    public func validate(email: String) -> Bool {
        return validateEmail?(email) ?? false
    }

    public func validate(password: String) -> Bool {
        return validatePassword?(password) ?? false
    }
}
