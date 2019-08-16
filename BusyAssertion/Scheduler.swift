//
//  Scheduler.swift
//  BusyAssertion
//
//  Created by Vadym Bulavin on 8/15/19.
//  Copyright © 2019 Vadym Bulavin. All rights reserved.
//

import Foundation

class Scheduler: NSObject {
    private let interval: TimeInterval
    private var timer: Timer?
    private var onFire: () -> Void
    
    init(interval: TimeInterval, onFire: @escaping () -> Void) {
        self.interval = interval
        self.onFire = onFire
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(ping), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    @objc private func ping() {
        onFire()
    }
}
