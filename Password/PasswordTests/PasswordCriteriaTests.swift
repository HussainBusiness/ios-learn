//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Hussain Mostafa Al Haddad on 06/11/2022.
//


import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {

    // Boundary conditions 8-32
    
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234567"))
    }

    func testLong() throws {
        // 🕹
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("012345678901234567890123456789123"))
    }
    
    func testValidShort() throws {
        // 🕹
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
    }

    func testValidLong() throws {
        // 🕹
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("01234567890123456789012345678912"))
    }
}

class PasswordOtherCriteriaTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("abc"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("a bc"))
    }
    
    func testLengthAndNoSpaceNotMet() throws{
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("1 234567"))
    }
    
    func testLengthAndNoSpaceMet() throws{
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("12345679"))
    }
    
    func testUpperCaseMet() throws{
        XCTAssertTrue(PasswordCriteria.uppercaseMet("A"))
    }
    
    func testUpperCaseNotMet() throws{
        XCTAssertFalse(PasswordCriteria.uppercaseMet("a"))
    }
    
    func testLowerCaseMet() throws{
        XCTAssertFalse(PasswordCriteria.lowercaseMet("A"))
    }
    
    func testLowerCaseNotMet() throws{
        XCTAssertTrue(PasswordCriteria.lowercaseMet("a"))
    }
    
    func testDigitMet() throws{
        XCTAssertTrue(PasswordCriteria.digitMet("1"))
    }
    
    func testDigitNotMet() throws{
        XCTAssertFalse(PasswordCriteria.digitMet("cxxxx"))
    }
    
    func testSpecialCharacterMet() throws{
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("@"))
    }
    
    func testSpecialCharacterNotMet() throws{
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("cxxxx"))
    }

    
}
