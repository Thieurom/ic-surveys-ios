//
//  ExampleTests.swift
//  NimbleSurveyUITests
//
//  Created by Doan Thieu on 29/09/2022.
//

import XCTest

class ExampleTests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }

    // TODO: Remove this test function
    // This test was created just to verify the fastlane setup for testing is working.
    func testExample() {
        XCTAssertTrue(true)
    }
}
