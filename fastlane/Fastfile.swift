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
            scheme: .userDefined(Parameterfile.scheme),
            devices: .userDefined(Parameterfile.devices),
            onlyTesting: [Parameterfile.testsTarget, Parameterfile.uiTestsTarget],
            clean: true,
            outputDirectory: Parameterfile.outputDirectory,
            outputTypes: Parameterfile.outputTypes,
            xcodebuildFormatter: Parameterfile.xcodebuildFormatter,
            xcargs: .userDefined("CI=true")
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
}
