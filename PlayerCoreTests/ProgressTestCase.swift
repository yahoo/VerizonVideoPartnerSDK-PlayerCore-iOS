//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class ProgressTestCase: XCTestCase {
    func testInit() {
        var sut = Progress(-100)
        XCTAssertEqual(sut.value, 0)
        sut = Progress(100)
        XCTAssertEqual(sut.value, 1)
        sut = Progress(0.5)
        XCTAssertEqual(sut.value, 0.5)
        sut = Progress(CGFloat(0.5))
        XCTAssertEqual(sut.value, 0.5)
        sut = Progress(4)
        XCTAssertEqual(sut.value, 1)
        sut = Progress(Double.nan)
        XCTAssertEqual(sut.value, 0)
    }
    
    func testLastPlayedQuartile() {
        var sut = Progress(-1)
        XCTAssertEqual(sut.lastPlayedQuartile, 0)
        sut = Progress(0.2)
        XCTAssertEqual(sut.lastPlayedQuartile, 0)
        sut = Progress(0.4)
        XCTAssertEqual(sut.lastPlayedQuartile, 1)
        sut = Progress(0.6)
        XCTAssertEqual(sut.lastPlayedQuartile, 2)
        sut = Progress(0.8)
        XCTAssertEqual(sut.lastPlayedQuartile, 3)
        sut = Progress(1)
        XCTAssertEqual(sut.lastPlayedQuartile, 4)
        sut = Progress(5)
        XCTAssertEqual(sut.lastPlayedQuartile, 4)
    }
    
    func testLastPlayedDecile() {
        var sut = Progress(0.2)
        XCTAssertEqual(sut.lastPlayedDecile, 2)
        sut = Progress(0.4)
        XCTAssertEqual(sut.lastPlayedDecile, 4)
        sut = Progress(1)
        XCTAssertEqual(sut.lastPlayedDecile, 10)
        sut = Progress(2)
        XCTAssertEqual(sut.lastPlayedDecile, 10)
    }
    
    func testMultiply() {
        let sut = Progress(0.5)
        let time = CMTime(seconds: 10, preferredTimescale: 600)
        let actualTime = sut.multiply(time: time)
        let expectedTime = CMTime(seconds: 5, preferredTimescale: 600)
        XCTAssertEqual(actualTime, expectedTime)
    }
    
    func testIsMax() {
        var sut = Progress(0.5)
        XCTAssertEqual(sut.isMax, false)
        sut = Progress(1)
        XCTAssertEqual(sut.isMax, true)
    }
}
