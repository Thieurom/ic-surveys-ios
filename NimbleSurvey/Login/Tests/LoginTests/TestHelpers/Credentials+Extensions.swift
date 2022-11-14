//
//  Credentials+Extensions.swift
//  PilotTests
//
//  Created by Doan Thieu on 14/11/2022.
//

import Foundation
import SurveyClientType

extension Credentials {

    static func sample() -> Credentials {
        return .init(
            accessToken: "ACCESS_TOKEN",
            tokenType: "Bearer",
            refreshToken: "REFRESH_TOKEN",
            createdAt: Date(timeIntervalSince1970: 1_597_169_495),
            expiresIn: 7_200
        )
    }
}
