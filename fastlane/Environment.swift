//
//  Environment.swift
//  FastlaneRunner
//
//  Created by Doan Thieu on 10/10/2022.
//  Copyright © 2022 Joshua Liebowitz. All rights reserved.
//

import Foundation

struct Environment {

    enum Key: String {

        case firebaseAppId = "FIREBASE_APP_ID"
        case firebaseCLIToken = "FIREBASE_CLI_TOKEN"
    }

    static func firebaseAppId() -> String {
        return valueForKey(.firebaseAppId)
    }

    static func firebaseCLIToken() -> String {
        return valueForKey(.firebaseCLIToken)
    }
}

// MARK: - Private

extension Environment {

    private static func valueForKey(_ key: Key) -> String {
        guard let value = ProcessInfo.processInfo.environment[key.rawValue] else {
            fatalError("Environment variable \(key.rawValue) has not been set!")
        }

        return value
    }
}
