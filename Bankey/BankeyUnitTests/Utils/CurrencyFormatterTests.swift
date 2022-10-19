//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Hussain Mostafa Al Haddad on 10/10/2022.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase{
    
    var formatter: CurrencyFormatter = CurrencyFormatter()
    
    override class func setUp() {
        super.setUp()
        //formatter = CurrencyFormatter()
        
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws{
        let result = formatter.dollarsFormatted(727111.22)
        XCTAssertEqual(result, "$727,111.22")
    }
    
    func testZeroDollarsFormatted() throws{
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }
    
    
}
