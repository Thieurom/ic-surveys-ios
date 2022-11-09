//
//  Parameterfile.swift
//  FastlaneRunner
//
//  Created by Doan Thieu on 29/09/2022.
//  Copyright © 2022 Joshua Liebowitz. All rights reserved.
//

import Foundation

// Put all the parameters for fastlane here!
enum Parameterfile {

    static let projectDirectoryPath = FileManager.default.currentDirectoryPath
    static let devices = ["iPhone 8", "iPhone 13 Pro Max"]
    static let outputDirectory = "\(projectDirectoryPath)/test_output"
    static let outputTypes = ""
    static let xcodebuildFormatter = "xcbeautify"
    static let buildArguments = "CI=true"
    static let buildPath = "\(projectDirectoryPath)/Build"
    static let derivedDataPath = "\(projectDirectoryPath)/DerivedData"
    static let testerGroups = "Nimble"
}
