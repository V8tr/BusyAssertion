//
//  BusyAssertions.swift
//  BusyAssertionTests
//
//  Created by Vadym Bulavin on 8/15/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import XCTest

extension XCTest {
    func expectToEventually(_ condition: @autoclosure () -> Bool, timeout: TimeInterval = 1.0, message: String = "") {
        busyWait(
            condition(),
            for: timeout,
            onFulfilled: {},
            onTimeout: { XCTFail(message) }
        )
    }
    
    func expect(_ condition: @autoclosure () -> Bool, for duration: TimeInterval, message: String = "") {
        busyWait(
            !condition(),
            for: duration,
            onFulfilled: { XCTFail(message) },
            onTimeout: {}
        )
    }
    
    func busyWait(
        _ condition: @autoclosure () -> Bool,
        for duration: TimeInterval,
        onFulfilled: () -> Void,
        onTimeout: () -> Void
        ) {
        
        let runLoop = RunLoop.current
        let timeoutDate = Date(timeIntervalSinceNow: duration)
        
        repeat {
            if condition() {
                onFulfilled()
                return
            }
            runLoop.run(until: Date(timeIntervalSinceNow: 0.01))
        } while Date().compare(timeoutDate) == .orderedAscending
        
        onTimeout()
    }
}
