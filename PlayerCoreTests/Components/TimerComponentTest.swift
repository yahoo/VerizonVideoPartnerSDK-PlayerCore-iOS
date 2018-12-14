//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class TimerComponentTest: XCTestCase {
    
    let initial = TimerSession(state: .stopped,
                               startAdSession: nil,
                               allowedDuration: 5)
    
    func testComponent() {
        let startAt = Date(timeIntervalSince1970: 0)
        let startAction = StartTimer(date: startAt)
        var sut = reduce(state: initial, action: startAction)
        XCTAssertEqual(sut.startAdSession, startAt)
        XCTAssertEqual(sut.allowedDuration, 5)
        
        let pauseAction = PauseTimer(date: .init(timeIntervalSince1970: 2))
        sut = reduce(state: sut, action: pauseAction)
        XCTAssertEqual(sut.allowedDuration, 3)
        
        sut = reduce(state: sut, action: StopTimer(maxAdDuration: 5))
        XCTAssertEqual(sut.allowedDuration, 5)
        XCTAssertNil(sut.startAdSession)
    }
    
    func testRepeatedStartAction() {
        let startAt = Date(timeIntervalSince1970: 0)
        let startAction1 = StartTimer(date: startAt)
        var sut = reduce(state: initial, action: startAction1)
        XCTAssertEqual(sut.startAdSession, startAt)
        XCTAssertEqual(sut.allowedDuration, 5)
        
        let startAction2 = StartTimer(date: .init(timeIntervalSince1970: 2))
        sut = reduce(state: sut, action: startAction2)
        XCTAssertEqual(sut.startAdSession, startAt)
        XCTAssertEqual(sut.allowedDuration, 5)
    }
    
    func testRepeatedPauseAction() {
        let startAt = Date(timeIntervalSince1970: 0)
        var sut = reduce(state: initial, action: StartTimer(date: startAt))
        
        let pauseAction1 = PauseTimer(date: .init(timeIntervalSince1970: 2))
        sut = reduce(state: sut, action: pauseAction1)
        XCTAssertEqual(sut.startAdSession, startAt)
        XCTAssertEqual(sut.allowedDuration, 3)
        
        let pauseAction2 = PauseTimer(date: .init(timeIntervalSince1970: 4))
        sut = reduce(state: sut, action: pauseAction2)
        XCTAssertEqual(sut.startAdSession, startAt)
        XCTAssertEqual(sut.allowedDuration, 3)
    }
}
