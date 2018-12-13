//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class TimerActionCreatorTest: XCTestCase {
    
    let currentDate = Date(timeIntervalSince1970: 0)
    let maxAdDuration = 5
    
    func testStartPauseStopActions() {
        timerAction(currentAdState: .play,
                    timerState: .stopped,
                    adStreamRate: true,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        guard let action = $0 as? StartTimer else { return XCTFail("Wrong action") }
                        XCTAssertTrue(action.date == self.currentDate)
        })
        timerAction(currentAdState: .play,
                    timerState: .running,
                    adStreamRate: false,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        guard let action = $0 as? PauseTimer else { return XCTFail("Wrong action") }
                        XCTAssertTrue(action.date == self.currentDate)
        })
        timerAction(currentAdState: .play,
                    timerState: .running,
                    adStreamRate: true,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        guard let action = $0 as? StartTimer else { return XCTFail("Wrong action") }
                        XCTAssertTrue(action.date == self.currentDate)
        })
        timerAction(currentAdState: .empty,
                    timerState: .paused,
                    adStreamRate: false,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        guard let action = $0 as? StopTimer else { return XCTFail("Wrong action") }
                        XCTAssertTrue(action.maxAdDuration == self.maxAdDuration)
        })
    }
    
    func testRepeatedActions() {
        timerAction(currentAdState: .play,
                    timerState: .stopped,
                    adStreamRate: true,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        guard let action = $0 as? StartTimer else { return XCTFail("Wrong action") }
                        XCTAssertTrue(action.date == self.currentDate)
        })
        timerAction(currentAdState: .play,
                    timerState: .running,
                    adStreamRate: true,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        XCTFail("Extra action dispatched - \($0)")
        })
        timerAction(currentAdState: .play,
                    timerState: .running,
                    adStreamRate: false,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        guard let action = $0 as? PauseTimer else { return XCTFail("Wrong action") }
                        XCTAssertTrue(action.date == self.currentDate)
        })
        timerAction(currentAdState: .play,
                    timerState: .paused,
                    adStreamRate: false,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        XCTFail("Extra action dispatched - \($0)")
        })
        timerAction(currentAdState: .empty,
                    timerState: .paused,
                    adStreamRate: false,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        guard let action = $0 as? StopTimer else { return XCTFail("Wrong action") }
                        XCTAssertTrue(action.maxAdDuration == self.maxAdDuration)
        })
        timerAction(currentAdState: .empty,
                    timerState: .stopped,
                    adStreamRate: false,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        XCTFail("Extra action dispatched - \($0)")
        })
    }
    
    func testNoActionsExpected() {
        timerAction(currentAdState: .empty,
                    timerState: .stopped,
                    adStreamRate: true,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        XCTFail("Extra action dispatched - \($0)")
        })
        timerAction(currentAdState: .play,
                    timerState: .stopped,
                    adStreamRate: false,
                    maxAdDuration: maxAdDuration,
                    currentTime: currentDate,
                    dispatcher: {
                        XCTFail("Extra action dispatched - \($0)")
        })
        
    }
}
