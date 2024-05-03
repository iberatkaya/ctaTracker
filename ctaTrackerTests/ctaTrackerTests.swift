//
//  ctaTrackerTests.swift
//  ctaTrackerTests
//
//  Created by Ibrahim Berat Kaya on 5/2/24.
//

import XCTest
@testable import ctaTracker

final class UntilFunctionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseStringToNumTests() throws {
        let numArr = parseNumbersFromString("abc12e34ts567")
        XCTAssertEqual(numArr, [12, 34, 567])
    }
}
