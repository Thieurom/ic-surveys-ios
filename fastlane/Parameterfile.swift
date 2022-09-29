//
//  Parameterfile.swift
//  FastlaneRunner
//
//  Created by Doan Thieu on 29/09/2022.
//  Copyright © 2022 Joshua Liebowitz. All rights reserved.
//

// Put all the parameters for fastlane here!
enum Parameterfile {

    static let projectName = "NimbleSurvey"
    static let scheme = projectName
    static let target = projectName
    static let testsTarget = "\(projectName)Tests"
    static let uiTestsTarget = "\(projectName)UITests"
    static let devices = ["iPhone 8", "iPhone 13 Pro Max"]
    static let outputDirectory = "./fastlane/test_output"
    static let outputTypes = ""
    static let xcodebuildFormatter = "xcbeautify"
}
