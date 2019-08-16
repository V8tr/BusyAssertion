//
//  BusyAssertionTests.swift
//  BusyAssertionTests
//
//  Created by Vadym Bulavin on 8/16/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import XCTest

class BusyAssertionTests: XCTestCase {

    func testWithoutBusyAssertion() {
        var oneTwo: [Int] = []
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            oneTwo.append(1)
            oneTwo.append(2)
        }
        // Must fail
        XCTAssertEqual(oneTwo, [1, 2])
    }
    
    func testUsingBusyAssertion() {
        var oneTwo: [Int] = []
        DispatchQueue.global().async {
            oneTwo.append(1)
            oneTwo.append(2)
        }
        expectToEventually(oneTwo == [1, 2])
    }
}
