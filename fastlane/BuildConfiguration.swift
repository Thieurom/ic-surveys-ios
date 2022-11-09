//
//  BuildConfiguration.swift
//  FastlaneRunner
//
//  Created by Doan Thieu on 09/10/2022.
//  Copyright © 2022 Joshua Liebowitz. All rights reserved.
//

import Foundation

enum BuildConfiguration: String {

    case staging
    case production
}

extension BuildConfiguration: CustomStringConvertible {

    var description: String { rawValue }
}

extension BuildConfiguration {

    var outputName: String {
        switch self {
        case .staging: return "\(Module.app(.staging).name) Staging"
        case .production: return Module.app(.production).name
        }
    }

    var firebaseAppId: String { Environment.firebaseAppId() }
}
