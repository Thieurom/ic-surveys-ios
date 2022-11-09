//
//  Credentials.swift
//
//
//  Created by Doan Thieu on 13/10/2022.
//

import Foundation

public struct Credentials: Equatable, Codable {

    public let accessToken: String
    public let tokenType: String
    public let refreshToken: String
    public let createdAt: Date
    public let expiresIn: Int

    public init(accessToken: String, tokenType: String, refreshToken: String, createdAt: Date, expiresIn: Int) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.refreshToken = refreshToken
        self.createdAt = createdAt
        self.expiresIn = expiresIn
    }
}

extension Credentials {

    public var validUntil: Date {
        createdAt.addingTimeInterval(TimeInterval(expiresIn))
    }
}
