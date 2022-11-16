import Validating
import XCTest
@testable import Validator

final class ValidatorTests: XCTestCase {

    private var validator: Validator!

    override func setUp() {
        super.setUp()
        validator = Validator()
    }

    override func tearDown() {
        validator = nil
        super.tearDown()
    }
}

extension ValidatorTests {

    func testValidateEmail_EmptyEmail_ReturnFalse() {
        XCTAssertFalse(validator.validate(email: ""))
    }

    func testValidateEmail_NotCorrectFormat_ReturnFalse() {
        XCTAssertFalse(validator.validate(email: "abc"))
    }

    func testValidateEmail_NotValidDomainPart_ReturnFalse() {
        XCTAssertFalse(validator.validate(email: "a@b.c"))
    }

    func testValidateEmail_CorrectFormat_ReturnTrue() {
        XCTAssertTrue(validator.validate(email: "a@b.co"))
    }

    func testValidateEmail_InvalidCharacter_ReturnFalse() {
        XCTAssertFalse(validator.validate(email: "%@b.co"))
    }
}

extension ValidatorTests {

    func testValidatePassword_EmptyPassword_ReturnFalse() {
        XCTAssertFalse(validator.validate(password: ""))
    }

    func testValidatePassword_PasswordHasOneLetters_ReturnFalse() {
        XCTAssertFalse(validator.validate(password: "1"))
    }

    func testValidatePassword_PasswordHasFourLetters_ReturnFalse() {
        XCTAssertFalse(validator.validate(password: "1234"))
    }

    func testValidatePassword_PasswordHasSevenLetters_ReturnFalse() {
        XCTAssertFalse(validator.validate(password: "1234567"))
    }

    func testValidatePassword_PasswordHasEightLetters_ReturnFalse() {
        XCTAssertTrue(validator.validate(password: "12345678"))
    }

    func testValidatePassword_PasswordHasNineLetters_ReturnFalse() {
        XCTAssertTrue(validator.validate(password: "1234567890"))
    }
}
