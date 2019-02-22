//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class LoadedTimeRangesComponentTestCase: XCTestCase {
    let initial = LoadedTimeRanges(content: [CMTimeRange()],
                                   ad: [CMTimeRange()])
    
    func testUpdateContentLoadedTimeRanges() {
        let sut = reduce(state: initial,
                         action: UpdateContentLoadedTimeRanges(newValue: [
                            CMTimeRange(start: 0 |> toCMTime,
                                        end: 5 |> toCMTime)]))
        XCTAssertEqual(sut.ad.count, 1)
        XCTAssertEqual(sut.ad[0].start, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.ad[0].end, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.content.count, 1)
        XCTAssertEqual(sut.content[0].start, 0 |> toCMTime)
        XCTAssertEqual(sut.content[0].end, 5 |> toCMTime)
    }
    
    func testUpdateAdLoadedTimeRanges() {
        let sut = reduce(state: initial,
                         action: UpdateAdLoadedTimeRanges(newValue: [
                            CMTimeRange(start: 0 |> toCMTime,
                                        end: 5 |> toCMTime)]))
        XCTAssertEqual(sut.content.count, 1)
        XCTAssertEqual(sut.content[0].start, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.content[0].end, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.ad.count, 1)
        XCTAssertEqual(sut.ad[0].start, 0 |> toCMTime)
        XCTAssertEqual(sut.ad[0].end, 5 |> toCMTime)
    }
    
    func testShowContent() {
        let sut = reduce(state: initial,
                         action: ShowContent())
        
        XCTAssertEqual(sut.content.count, initial.content.count)
        XCTAssertEqual(sut.ad.count, 1)
        XCTAssertEqual(sut.ad[0].start, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.ad[0].end, (0, 0) |> toCMTime)
    }
    
    func testShowMP4Ad() {
        let sut = reduce(state: initial,
                         action: ShowMP4Ad(creative: AdCreative.mp4(with: testUrl), id: UUID()))
        XCTAssertEqual(sut.ad.count, 0)
        XCTAssertEqual(sut.content.count, 1)
        XCTAssertEqual(sut.content[0].start, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.content[0].end, (0, 0) |> toCMTime)
    }
    
    func testShowVPAIDAd() {
        let sut = reduce(state: initial,
                         action: ShowVPAIDAd(creative: AdCreative.vpaid(with: testUrl), id: UUID()))
        XCTAssertEqual(sut.ad.count, 0)
        XCTAssertEqual(sut.content.count, 1)
        XCTAssertEqual(sut.content[0].start, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.content[0].end, (0, 0) |> toCMTime)
    }
    
    func testSelectVideoAtIdx() {
        let sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 0, id: UUID(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut.ad.count, 0)
        XCTAssertEqual(sut.content.count, 0)
    }
    
    func testIgnoreOtherActions() {
        let sut = reduce(state: initial, action: Play(time: Date()))
        XCTAssertEqual(sut.ad.count, 1)
        XCTAssertEqual(sut.ad[0].start, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.ad[0].end, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.content.count, 1)
        XCTAssertEqual(sut.content[0].start, (0, 0) |> toCMTime)
        XCTAssertEqual(sut.content[0].end, (0, 0) |> toCMTime)
    }
}
