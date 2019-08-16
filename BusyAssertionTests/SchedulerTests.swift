//
//  SchedulerTests.swift
//  BusyAssertionTests
//
//  Created by Vadym Bulavin on 8/15/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import XCTest
@testable import BusyAssertion

class SchedulerTests: XCTestCase {

    func testDoesNotFireImmediately() {
        var didFire = false
        
        let sut = Scheduler(interval: 10) {
            didFire = true
        }
        
        sut.start()
        
        // Must fail
        expect(didFire == false, for: 1.0)
    }
}
