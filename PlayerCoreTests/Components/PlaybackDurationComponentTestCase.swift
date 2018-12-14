//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlaybackDurationComponentTestCase: XCTestCase {
    let initial = PlaybackDuration(startTime: nil, duration: 0)
    
    func testUpdateContentPlayerRateReduce() {
        let time = Date()
        var sut = reduce(state: initial,
                         action: UpdateContentStreamRate(time: time, rate: true))
        XCTAssertEqual(sut.startTime, time)
        XCTAssertEqual(sut.duration, 0)
        
        sut = reduce(state: sut,
                     action: UpdateContentStreamRate(time: time, rate: false))
        XCTAssertEqual(sut.startTime, time)
        XCTAssertEqual(sut.duration, 0)
    }
    
    func testSelectVideoAtIdx() {
        let initial = PlaybackDuration(startTime: .init(), duration: 100)
        let sut = reduce(state: initial,
                         action: SelectVideoAtIdx(idx: 0, id: .init(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut.startTime, nil)
        XCTAssertEqual(sut.duration, 0)
    }
    
    func testOtherActions() {
        let sut = reduce(state: initial,
                         action: Play(time: .init()))
        XCTAssertEqual(sut.startTime, nil)
        XCTAssertEqual(sut.duration, 0)
    }
    
    func testUpdateContentCurrentTime() {
        var date = Date()
        var sut = reduce(state: initial,
                         action: UpdateContentCurrentTime(newTime: 6 |> toCMTime, currentDate: date))
        XCTAssertEqual(sut.startTime, nil)
        XCTAssertEqual(sut.duration, 0)
        
        sut = reduce(state: PlaybackDuration(startTime: date, duration: 0),
                     action: UpdateContentCurrentTime(newTime: 5 |> toCMTime, currentDate: date))
        XCTAssertEqual(sut.startTime, date)
        XCTAssertEqual(sut.duration, 0)
        
        date.addTimeInterval(1)
        sut = reduce(state: sut,
                     action: UpdateContentCurrentTime(newTime: 6 |> toCMTime, currentDate: date))
        XCTAssertEqual(sut.startTime, date)
        XCTAssertEqual(sut.duration, 1)
    }
}
