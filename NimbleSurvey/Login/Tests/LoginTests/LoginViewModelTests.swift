import Combine
import SurveyClientType
import XCTest
@testable import Login

final class LoginViewModelTests: XCTestCase {

    private var viewModel: LoginViewModel!
    private var surveyClient: MockSurveyClient!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        surveyClient = MockSurveyClient()
        viewModel = LoginViewModel(surveyClient: surveyClient)
        cancellables = []
    }

    override func tearDown() {
        surveyClient = nil
        viewModel = nil
        super.tearDown()
    }

    func test_InitialValues() {
        XCTAssertFalse(viewModel.isLoginEnabled)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.loginResult)
    }

    func testLogin_WhenSurveyClientReturnFail() {
        surveyClient.authenticateResult = Fail<Credentials, SurveyError>(error: SurveyError.unknown)
            .eraseToAnyPublisher()

        var isLoginEnabled = [Bool]()
        var isLoading = [Bool]()
        var loginResult = [(title: String, description: String)]()

        let isLoginEnabledExpectation = expectation(description: "isLoginEnabled")
        let isLoadingExpectation = expectation(description: "isLoading")
        let loginResultExpectation = expectation(description: "loginResult")

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

        wait(for: [isLoginEnabledExpectation, isLoadingExpectation, loginResultExpectation], timeout: 1.0)

        XCTAssertEqual(isLoading, [false, true, false])
        XCTAssertEqual(isLoginEnabled, [false, false, true])
        XCTAssertEqual(loginResult.map(\.title), ["Unable to login"])
        XCTAssertEqual(loginResult.map(\.description), ["There's something wrong. Please try again!"])
    }

    func testLogin_WhenSurveyClientReturnSuccess() {
        surveyClient.authenticateResult = Just(Credentials.sample())
            .setFailureType(to: SurveyError.self)
            .eraseToAnyPublisher()

        var isLoginEnabled = [Bool]()
        var isLoading = [Bool]()
        var loginResult = [(title: String, description: String)]()

        let isLoginEnabledExpectation = expectation(description: "isLoginEnabled")
        let isLoadingExpectation = expectation(description: "isLoading")
        let loginResultExpectation = expectation(description: "loginResult")

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

        wait(for: [isLoginEnabledExpectation, isLoadingExpectation, loginResultExpectation], timeout: 1.0)

        XCTAssertEqual(isLoading, [false, true, false])
        XCTAssertEqual(isLoginEnabled, [false, false, true])
        XCTAssertEqual(loginResult.map(\.title), ["Login successfully"])
        XCTAssertEqual(loginResult.map(\.description), ["You've been logged in!"])    }
}
