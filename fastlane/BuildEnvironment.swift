//
//  BuildEnvironment.swift
//  FastlaneRunner
//
//  Created by Doan Thieu on 09/10/2022.
//  Copyright © 2022 Joshua Liebowitz. All rights reserved.
//

enum BuildEnvironment: String {

    case staging
    case production
}

extension BuildEnvironment: CustomStringConvertible {

    var description: String { rawValue }
}

extension BuildEnvironment {

    var scheme: String {
        switch self {
        case .staging: return "\(Parameterfile.projectName) Staging"
        case .production: return Parameterfile.projectName
        }
    }

    var outputName: String {
        switch self {
        case .staging: return "\(Parameterfile.projectName) Staging"
        case .production: return Parameterfile.projectName
        }
    }
}
