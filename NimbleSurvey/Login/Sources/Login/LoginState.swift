//
//  LoginState.swift
//  Login
//
//  Created by Doan Thieu on 21/11/2022.
//

import Foundation

public final class LoginState: ObservableObject {

    @Published public var isLoginSuccessfully = false

    public init() {}
}
