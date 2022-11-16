//
//  Validating.swift
//  DataValidation
//
//  Created by Doan Thieu on 16/11/2022.
//

public protocol Validating {

    func validate(email: String) -> Bool
    func validate(password: String) -> Bool
}
