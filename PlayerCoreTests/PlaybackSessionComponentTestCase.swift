//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlaybackSessionComponentTestCase: XCTestCase {
    func testReduceOnSelectVideoAtIdx() {
        let initial = PlaybackSession(id: UUID(), intentTime: Date(), startTime: Date(), isCompleted: true)
        let id = UUID()
        let sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 1,
                                                                  id: id,
                                                                  hasPrerollAds: false,
                                                                  midrolls: []))
        XCTAssertEqual(sut.id, id)
        XCTAssertNil(sut.intentTime)
        XCTAssertNil(sut.startTime)
        XCTAssertFalse(sut.isCompleted)
    }
    
    func testReduceOnPlay() {
        let date = Date()
        let initial = PlaybackSession(id: UUID(), intentTime: nil, startTime: Date(), isCompleted: false)
        let sut = reduce(state: initial, action: Play(time: date))
        XCTAssertEqual(sut.intentTime, date)
    }
    
    func testReduceOnUpdateContentStreamRate() {
        let initial = PlaybackSession(id: UUID(), intentTime: nil, startTime: nil, isCompleted: false)
        let time = Date()
        let sut = reduce(state: initial, action: UpdateContentStreamRate(time: time, rate: true))
        XCTAssertEqual(sut.startTime, time)
    }
    
    func testReduceOnUpdateContentCurrentTime() {
        let initial = PlaybackSession(id: UUID(), intentTime: nil, startTime: nil, isCompleted: true)
        let sut = reduce(state: initial, action: UpdateContentCurrentTime(newTime: 5 |> toCMTime, currentDate: Date()))
        XCTAssertFalse(sut.isCompleted)
    }
    
    func testReduceOnCompletePlaybackSession() {
        let initial = PlaybackSession(id: UUID(), intentTime: nil, startTime: nil, isCompleted: false)
        let sut = reduce(state: initial, action: CompletePlaybackSession())
        XCTAssertTrue(sut.isCompleted)
    }
}
