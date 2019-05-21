//
//  CodingChallangeTests.swift
//  CodingChallangeTests
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import XCTest
@testable import CodingChallange

class CodingChallangeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    /// The Below functional test, tests if a crash occurs when no data returns from api call
    /// test handling null response
    func testCallToGithub() {
        var responseError: Error?
        var apiResponse: ApiResponse?
        let expectation = self.expectation(description: "fetching data should not crash when null data returns")

        apiManager.fetchRepositories(date: "1990-12-12", page: 2000) { (response, error) in
            responseError = error
            apiResponse = response
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNil(responseError)
        XCTAssertNotNil(apiResponse)
        XCTAssertNil(apiResponse?.total_count)
        XCTAssertNil(apiResponse?.items)
        XCTAssertNil(apiResponse?.incomplete_results)

    }
   
}
