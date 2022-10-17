import Combine
import Mocker
import SurveyClientType
import XCTest
@testable import SurveyClient

final class SurveyClientTests: XCTestCase {

    var surveyClient: SurveyClient!
    private var mockURLSession: URLSession!
    private var cancellables: Set<AnyCancellable>!

    private let email = "john@appleseed.com"
    private let password = "123456"
    private let clientId = "ID"
    private let clientSecret = "SECRET"

    override func setUp() {
        super.setUp()

        mockURLSession = MockingURLProtocol.urlSession()
        surveyClient = SurveyClient(
            clientId: clientId,
            clientSecret: clientSecret,
            urlSession: mockURLSession
        )
        cancellables = []
    }

    override func tearDown() {
        surveyClient = nil
        super.tearDown()
    }
}

// MARK: - authenticate()

extension SurveyClientTests {

    func testAuthenticate_APIReturnError_GetError() {
        var error: SurveyError!
        let expectation = expectation(description: "authenticate")
        MockingURLProtocol.mock = Mock(statusCode: 400, error: TestHelpers.Error.fail, data: nil)

        surveyClient.authenticate(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case let .failure(encounterError) = completion {
                    error = encounterError
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)

        XCTAssertTrue(error == .unknown)
    }

    func testAuthenticate_APIReturnNonOkStatusCode_GetError() {
        var error: SurveyError!
        let expectation = expectation(description: "authenticate")
        MockingURLProtocol.mock = Mock(statusCode: 400, error: nil, data: nil)

        surveyClient.authenticate(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case let .failure(encounterError) = completion {
                    error = encounterError
                    expectation.fulfill()
                }

            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)

        XCTAssertTrue(error == .badRequest)
    }

    func testAuthenticate_APIReturnEmptyData_GetError() {
        var error: SurveyError!
        let expectation = expectation(description: "authenticate")
        MockingURLProtocol.mock = Mock(statusCode: 200, error: nil, data: Data())

        surveyClient.authenticate(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case let .failure(encounterError) = completion {
                    error = encounterError
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)

        XCTAssertTrue(error == .badData)
    }

    func testAuthenticate_APIReturnWrongFormatData_GetError() {
        var error: SurveyError!
        let expectation = expectation(description: "authenticate")

        // Wrong key: `accessing_token` instead of `access_token`
        let json = """
        {
            "data": {
                "id": "10",
                "type": "token",
                "attributes": {
                    "accessing_token": "ACCESS_TOKEN",
                    "token_type": "Bearer",
                    "expires_in": 7200,
                    "refresh_token": "REFRESH_TOKEN",
                    "created_at": 1597169495
                }
            }
        }
        """

        MockingURLProtocol.mock = Mock(statusCode: 200, error: nil, json: json)

        surveyClient.authenticate(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case let .failure(encounterError) = completion {
                    error = encounterError
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)

        XCTAssertTrue(error == .badData)
    }

    func testAuthenticate_APIGotProperData_ReturnsSuccess() {
        var credentials: Credentials!

        let accessToken = "ACCESS_TOKEN"
        let tokenType = "Bearer"
        let expiresIn = 7_200
        let refreshToken = "REFRESH_TOKEN"
        let createdAt = 1_597_169_495

        let expectedCredentials = Credentials(
            accessToken: accessToken,
            tokenType: tokenType,
            refreshToken: refreshToken,
            createdAt: Date(timeIntervalSince1970: TimeInterval(createdAt)),
            expiresIn: expiresIn
        )

        let expectation = expectation(description: "authenticate")

        let json = """
        {
            "data": {
                "id": "10",
                "type": "token",
                "attributes": {
                    "access_token": "\(accessToken)",
                    "token_type": "Bearer",
                    "expires_in": \(expiresIn),
                    "refresh_token": "\(refreshToken)",
                    "created_at": \(createdAt)
                }
            }
        }
        """

        MockingURLProtocol.mock = Mock(statusCode: 200, error: nil, json: json)

        surveyClient.authenticate(email: email, password: password)
            .sink(receiveCompletion: { _ in
            }, receiveValue: { value in
                credentials = value
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0)

        XCTAssertTrue(credentials == expectedCredentials)
    }
}
