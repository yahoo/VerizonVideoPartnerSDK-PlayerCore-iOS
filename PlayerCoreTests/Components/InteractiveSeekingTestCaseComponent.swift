//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class InteractiveSeekingTestCaseComponent: XCTestCase {
    let initial = InteractiveSeeking(isSeekingInProgress: false)
    
    func testReduceOnBeginInteractiveSeeking() {
        let sut = reduce(state: initial, action: StartInteractiveSeeking(newTime: CMTime.zero))
        XCTAssertEqual(sut.isSeekingInProgress, true)
    }
    
    func testReduceOnEndInteractiveSeeking() {
        let sut = reduce(state: initial, action: StopInteractiveSeeking(newTime: CMTime.zero))
        XCTAssertEqual(sut.isSeekingInProgress, false)
    }
    
    func testReduceOnSelectVideoAtIdx() {
        let sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 0, id: .init(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut.isSeekingInProgress, false)
    }
    
    func testReduceOnShowAd() {
        var sut = reduce(state: initial, action: ShowMP4Ad(creative: AdCreative.mp4(with: testUrl), id: UUID()))
        XCTAssertEqual(sut.isSeekingInProgress, false)
        
        sut = reduce(state: initial, action: ShowVPAIDAd(creative: AdCreative.vpaid(with: testUrl), id: UUID()))
        XCTAssertEqual(sut.isSeekingInProgress, false)
    }
    
    func testReduceOnShowContent() {
        let sut = reduce(state: initial, action: ShowContent())
        XCTAssertEqual(sut.isSeekingInProgress, false)
    }
    
    func testReduceOnOtherActions() {
        let sut = reduce(state: initial, action: Play(time: .init()))
        XCTAssertEqual(sut.isSeekingInProgress, false)
    }
    
    func testReduceOnStartSeek() {
        let sut = reduce(state: initial, action: Play(time: .init()))
        XCTAssertEqual(sut.isSeekingInProgress, false)
    }
}
