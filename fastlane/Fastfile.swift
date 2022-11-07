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
            scheme: .userDefined(BuildConfiguration.staging.scheme),
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

        buildApp(configuration: .staging, signingType: .adHoc)
    }

    func distributeToFirebaseStagingLane() {
        desc("Distribute app to Firebase staging")

        bumpBuildNumber()
        buildApp(configuration: .staging, signingType: .adHoc)
        distributeToFirebase(configuration: .staging, releaseNotes: "")
        cleanUpBuildLane()
    }

    func cleanUpBuildLane() {
        desc("Clean up build artifacts")

        clearDerivedData(derivedDataPath: Parameterfile.derivedDataPath)
        try? FileManager.default.removeItem(atPath: Parameterfile.buildPath)
    }
}

// MARK: - Private

extension Fastfile {

    private func buildApp(configuration: BuildConfiguration, signingType: SigningType) {
        FastlaneRunner.buildApp(
            scheme: .userDefined(configuration.scheme),
            clean: .userDefined(true),
            outputDirectory: Parameterfile.buildPath,
            outputName: .userDefined(configuration.outputName),
            silent: .userDefined(true),
            includeSymbols: .userDefined(true),
            exportMethod: .userDefined(signingType.rawValue),
            buildPath: .userDefined(Parameterfile.buildPath),
            derivedDataPath: .userDefined(Parameterfile.derivedDataPath),
            xcargs: .userDefined(Parameterfile.buildArguments),
            xcodebuildFormatter: Parameterfile.xcodebuildFormatter
        )
    }

    private func distributeToFirebase(configuration: BuildConfiguration, releaseNotes: String? = nil) {
        firebaseAppDistribution(
            app: .userDefined(configuration.firebaseAppId),
            groups: .userDefined(Parameterfile.testerGroups),
            releaseNotes: .userDefined(releaseNotes),
            firebaseCliToken: .userDefined(Secret.firebaseCLIToken)
        )
    }

    private func bumpBuildNumber() {
        incrementBuildNumber(buildNumber: .userDefined(String(numberOfCommits())))
    }
}
