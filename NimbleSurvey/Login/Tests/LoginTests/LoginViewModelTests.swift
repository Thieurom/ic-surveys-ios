import Combine
import SurveyClientType
import Validating
import XCTest
@testable import Login

final class LoginViewModelTests: XCTestCase {

    private var viewModel: LoginViewModel!
    private var surveyClient: MockSurveyClient!
    private var validator: MockValidator!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        surveyClient = MockSurveyClient()
        validator = MockValidator()
        viewModel = LoginViewModel(surveyClient: surveyClient, validator: validator)
        cancellables = []
    }

    override func tearDown() {
        validator = nil
        surveyClient = nil
        viewModel = nil
        super.tearDown()
    }

    func test_InitialValues() {
        XCTAssertFalse(viewModel.isLoginEnabled)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.loginResult)
    }

    func testLogin_WhenValidatorReturnFalse() {
        validator.validateEmail = { _ in false }
        validator.validatePassword = { _ in false }

        var isEmailValid = [Bool]()
        var isPasswordValid = [Bool]()
        var isLoginEnabled = [Bool]()
        var isLoading = [Bool]()
        var loginResult = [(title: String, description: String)]()

        let isEmailValidExpectation = expectation(description: "isEmailValid")
        let isPasswordValidExpectation = expectation(description: "isPasswordValid")
        let isLoginEnabledExpectation = expectation(description: "isLoginEnabled")
        let isLoadingExpectation = expectation(description: "isLoading")
        let loginResultExpectation = expectation(description: "loginResult")

        let expectations = [
            isEmailValidExpectation,
            isPasswordValidExpectation,
            isLoginEnabledExpectation,
            isLoadingExpectation,
            loginResultExpectation
        ]

        viewModel.$isEmailValid
            .collect(2)
            .first()
            .sink(receiveValue: {
                isEmailValid = $0
                isEmailValidExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isPasswordValid
            .collect(2)
            .first()
            .sink(receiveValue: {
                isPasswordValid = $0
                isPasswordValidExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isLoginEnabled
            .collect(2)
            .first()
            .sink(receiveValue: {
                isLoginEnabled = $0
                isLoginEnabledExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isLoading
            .collect(1)
            .first()
            .sink(receiveValue: {
                isLoading = $0
                isLoadingExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$loginResult
            .collect(1)
            .first()
            .sink(receiveValue: {
                loginResult = $0.compactMap { $0 }
                loginResultExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.email = "dev@test.com"
        viewModel.password = "12345678"
        viewModel.login()

        wait(for: expectations, timeout: 1.0)

        XCTAssertEqual(isEmailValid, [true, false])
        XCTAssertEqual(isPasswordValid, [true, false])
        XCTAssertEqual(isLoading, [false])
        XCTAssertEqual(isLoginEnabled, [false, false])
        XCTAssertTrue(loginResult.map(\.title).isEmpty)
        XCTAssertTrue(loginResult.map(\.description).isEmpty)
    }

    func testLogin_WhenValidatorReturnTrueAndSurveyClientReturnFail() {
        validator.validateEmail = { _ in true }
        validator.validatePassword = { _ in true }
        surveyClient.authenticateResult = Fail<Credentials, SurveyError>(error: SurveyError.unknown)
            .eraseToAnyPublisher()

        var isEmailValid = [Bool]()
        var isPasswordValid = [Bool]()
        var isLoginEnabled = [Bool]()
        var isLoading = [Bool]()
        var loginResult = [(title: String, description: String)]()

        let isEmailValidExpectation = expectation(description: "isEmailValid")
        let isPasswordValidExpectation = expectation(description: "isPasswordValid")
        let isLoginEnabledExpectation = expectation(description: "isLoginEnabled")
        let isLoadingExpectation = expectation(description: "isLoading")
        let loginResultExpectation = expectation(description: "loginResult")

        let expectations = [
            isEmailValidExpectation,
            isPasswordValidExpectation,
            isLoginEnabledExpectation,
            isLoadingExpectation,
            loginResultExpectation
        ]

        viewModel.$isEmailValid
            .collect(2)
            .first()
            .sink(receiveValue: {
                isEmailValid = $0
                isEmailValidExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isPasswordValid
            .collect(2)
            .first()
            .sink(receiveValue: {
                isPasswordValid = $0
                isPasswordValidExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isLoginEnabled
            .collect(3)
            .first()
            .sink(receiveValue: {
                isLoginEnabled = $0
                isLoginEnabledExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isLoading
            .collect(3)
            .first()
            .sink(receiveValue: {
                isLoading = $0
                isLoadingExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$loginResult
            .collect(2)
            .first()
            .sink(receiveValue: {
                loginResult = $0.compactMap { $0 }
                loginResultExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.email = "dev@test.com"
        viewModel.password = "12345678"
        viewModel.login()

        wait(for: expectations, timeout: 1.0)

        XCTAssertEqual(isEmailValid, [true, true])
        XCTAssertEqual(isPasswordValid, [true, true])
        XCTAssertEqual(isLoading, [false, true, false])
        XCTAssertEqual(isLoginEnabled, [false, false, true])
        XCTAssertEqual(loginResult.map(\.title), ["Unable to login"])
        XCTAssertEqual(loginResult.map(\.description), ["There's something wrong. Please try again!"])
    }

    func testLogin_WhenValidatorReturnTrueAndSurveyClientReturnSuccess() {
        validator.validateEmail = { _ in true }
        validator.validatePassword = { _ in true }
        surveyClient.authenticateResult = Just(Credentials.sample())
            .setFailureType(to: SurveyError.self)
            .eraseToAnyPublisher()

        var isEmailValid = [Bool]()
        var isPasswordValid = [Bool]()
        var isLoginEnabled = [Bool]()
        var isLoading = [Bool]()
        var loginResult = [(title: String, description: String)]()

        let isEmailValidExpectation = expectation(description: "isEmailValid")
        let isPasswordValidExpectation = expectation(description: "isPasswordValid")
        let isLoginEnabledExpectation = expectation(description: "isLoginEnabled")
        let isLoadingExpectation = expectation(description: "isLoading")
        let loginResultExpectation = expectation(description: "loginResult")

        let expectations = [
            isEmailValidExpectation,
            isPasswordValidExpectation,
            isLoginEnabledExpectation,
            isLoadingExpectation,
            loginResultExpectation
        ]

        viewModel.$isEmailValid
            .collect(2)
            .first()
            .sink(receiveValue: {
                isEmailValid = $0
                isEmailValidExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isPasswordValid
            .collect(2)
            .first()
            .sink(receiveValue: {
                isPasswordValid = $0
                isPasswordValidExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isLoginEnabled
            .collect(3)
            .first()
            .sink(receiveValue: {
                isLoginEnabled = $0
                isLoginEnabledExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$isLoading
            .collect(3)
            .first()
            .sink(receiveValue: {
                isLoading = $0
                isLoadingExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.$loginResult
            .collect(2)
            .first()
            .sink(receiveValue: {
                loginResult = $0.compactMap { $0 }
                loginResultExpectation.fulfill()
            })
            .store(in: &cancellables)

        viewModel.email = "dev@test.com"
        viewModel.password = "12345678"
        viewModel.login()

        wait(for: expectations, timeout: 1.0)

        XCTAssertEqual(isEmailValid, [true, true])
        XCTAssertEqual(isPasswordValid, [true, true])
        XCTAssertEqual(isLoading, [false, true, false])
        XCTAssertEqual(isLoginEnabled, [false, false, true])
        XCTAssertEqual(loginResult.map(\.title), ["Login successfully"])
        XCTAssertEqual(loginResult.map(\.description), ["You've been logged in!"])    }
}
