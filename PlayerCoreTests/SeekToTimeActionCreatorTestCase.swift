//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class SeekToTimeActionCreatorTestCase: XCTestCase {
    func testSeekToTime() {
        let sut = seekToTime(time: 5 |> toCMTime, in: 10 |> toCMTime) as? SeekToTime
        XCTAssertEqual(sut?.newTime, 5 |> toCMTime)
    }
    
    func testSeekToProgress() {
        var sut = seekToProgress(progress: 0.5, duration: 5 |> toCMTime) as? SeekToTime
        XCTAssertEqual(sut?.newTime, 2.5 |> toCMTime)
        
        sut = seekToProgress(progress: 500, duration: 10 |> toCMTime) as? SeekToTime
        XCTAssertEqual(sut?.newTime, 10 |> toCMTime)
        
        sut = seekToProgress(progress: -1000, duration: 10 |> toCMTime) as? SeekToTime
        XCTAssertEqual(sut?.newTime, 0 |> toCMTime)
        
        sut = seekToProgress(progress: 1, duration: CMTime.zero) as? SeekToTime
        XCTAssertEqual(sut?.newTime, (0, 1) |> toCMTime)
    }
    
    func testSeekToSeconds() {
        let sut = seekToSeconds(seconds: 10, timescale: 600, duration: 15 |> toCMTime) as? SeekToTime
        XCTAssertEqual(sut?.newTime, 10 |> toCMTime)
    }
}
