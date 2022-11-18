//
//  Module.swift
//  FastlaneRunner
//
//  Created by Doan Thieu on 23/10/2022.
//  Copyright © 2022 Joshua Liebowitz. All rights reserved.
//

enum Module {

    case app(BuildConfiguration)
    case surveyClient
    case login
}

extension Module {

    static let testModules: [Module] = [
        .surveyClient,
        .login,
        .app(.staging)
    ]
}

extension Module {

    var name: String {
        switch self {
        case .app: return "NimbleSurvey"
        case .surveyClient: return "SurveyClient"
        case .login: return "Login"
        }
    }

    var scheme: String {
        switch self {
        case let .app(buildConfig):
            switch buildConfig {
            case .staging: return "\(name) Staging"
            case .production: return name
            }
        default:
            return name
        }
    }

    var testsTargets: [String] {
        switch self {
        case .app:
            return ["\(name)Tests", "\(name)UITests"]
        default:
            return ["\(name)Tests"]
        }
    }

    var packagePath: String? {
        switch self {
        case .surveyClient:
            return "./\(Project.name)/\(Module.surveyClient.name)"
        case .login:
            return "./\(Project.name)/\(Module.login.name)"
        case .app:
            return nil
        }
    }
}
