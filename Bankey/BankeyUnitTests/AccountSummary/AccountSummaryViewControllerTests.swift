//
//  AccountSummaryViewControllerTests.swift
//  BankeyUnitTests
//
//  Created by Hussain Mostafa Al Haddad on 26/10/2022.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
            var profile: Profile?
            var error: NetworkError?
            
            func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
                completion(.success(profile!))
            }
        }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
        // vc.loadViewIfNeeded()
    }
    
    func testNetworkServerErrorMessageAndTitle() throws {
       
        let messageAndTitle = vc.titleAnMessageForTesting(.serverError)
        XCTAssertEqual("Server Error", messageAndTitle.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", messageAndTitle.1)
    }
    
    func testNetworkDecodingErrorMessageAndTitle() throws {
       
        let messageAndTitle = vc.titleAnMessageForTesting(.decodingError)
        XCTAssertEqual("Decoding Error", messageAndTitle.0)
        XCTAssertEqual("We could not process the request. Please try again.", messageAndTitle.1)
    }
    
    func testAlertForServerError() throws {
        mockManager.error = NetworkError.serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Decoding Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process the request. Please try again.", vc.errorAlert.message)
    }
}
