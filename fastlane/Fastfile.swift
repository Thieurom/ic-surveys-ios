// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {

    func testsLane() {
        desc("Build and tests")

        runTests(
            scheme: .userDefined(BuildEnvironment.staging.scheme),
            devices: .userDefined(Parameterfile.devices),
            onlyTesting: [Parameterfile.testsTarget, Parameterfile.uiTestsTarget],
            clean: true,
            outputDirectory: Parameterfile.outputDirectory,
            outputTypes: Parameterfile.outputTypes,
            xcodebuildFormatter: Parameterfile.xcodebuildFormatter,
            xcargs: .userDefined(Parameterfile.buildArguments)
        )
    }

    func lintLane() {
        desc("Run SwifLint")

        swiftlint(
            strict: true,
            ignoreExitStatus: true,
            raiseIfSwiftlintError: true
        )
    }

    func buildStagingLane() {
        desc("Build app for staging")

        buildApp(environment: .staging, signingType: .adHoc)
    }
}

// MARK: - Private

extension Fastfile {

    private func buildApp(environment: BuildEnvironment, signingType: SigningType) {
        FastlaneRunner.buildApp(
            scheme: .userDefined(environment.scheme),
            clean: .userDefined(true),
            outputDirectory: Parameterfile.buildPath,
            outputName: .userDefined(environment.outputName),
            silent: .userDefined(true),
            includeSymbols: .userDefined(true),
            exportMethod: .userDefined(signingType.rawValue),
            buildPath: .userDefined(Parameterfile.buildPath),
            derivedDataPath: .userDefined(Parameterfile.derivedDataPath),
            xcodebuildFormatter: Parameterfile.xcodebuildFormatter
        )
    }
}
