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
}

extension Module {

    var name: String {
        switch self {
        case .app: return "NimbleSurvey"
        case .surveyClient: return "SurveyClient"
        }
    }

    var scheme: String {
        switch self {
        case let .app(buildConfig):
            switch buildConfig {
            case .staging: return "\(name) Staging"
            case .production: return name
            }
        case .surveyClient:
            return name
        }
    }

    var testsTargets: [String] {
        switch self {
        case .app:
            return ["\(name)Tests", "\(name)UITests"]
        case .surveyClient:
            return ["\(name)Tests"]
        }
    }

    var packagePath: String? {
        guard case .surveyClient = self else {
            return nil
        }

        return "./\(Project.name)/\(Module.surveyClient.name)"
    }
}
