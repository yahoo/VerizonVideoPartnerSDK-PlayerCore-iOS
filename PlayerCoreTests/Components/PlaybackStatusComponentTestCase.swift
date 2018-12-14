//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlaybackStatusComponentTestCase: XCTestCase {
    
    let initial = Status.unknown
    
    func testReduceContentOnContentPlaybackReady() {
        let sut = reduceContent(state: initial, action: ContentPlaybackReady())
        XCTAssertEqual(sut, .ready)
    }
    
    func testReduceContentOnContentPlaybackFailed() {
        let error = NSError(domain: "domain", code: -100, userInfo: nil)
        let sut = reduceContent(state: initial, action: ContentPlaybackFailed(error: error))
        XCTAssertEqual(sut, .errored(error))
    }
    
    func testReduceContentOnSelectVideoAtIndex() {
        let sut = reduceContent(state: initial, action: SelectVideoAtIdx(idx: 0, id: UUID(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut, .unknown)
    }
    
    func testReduceContentOnOtherActions() {
        let sut = reduceContent(state: initial, action: Play(time: Date()))
        XCTAssertEqual(sut, .unknown)
    }
   
    func testReduceAdOnAdPlaybackReady() {
        let sut = reduceAd(state: initial, action: AdPlaybackReady())
        XCTAssertEqual(sut, .ready)
    }
    
    func testReduceAdOnAdPlaybackFailed() {
        let error = NSError(domain: "domain", code: -100, userInfo: nil)
        let sut = reduceAd(state: initial, action: AdPlaybackFailed(error: error))
        XCTAssertEqual(sut, .errored(error))
    }
    
    func testReduceAdOnSelectVideoAtIndex() {
        let sut = reduceAd(state: initial, action: SelectVideoAtIdx(idx: 0, id: UUID(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut, .unknown)
    }
    
    func testReduceAdOnOtherActions() {
        let sut = reduceAd(state: initial, action: Play(time: Date()))
        XCTAssertEqual(sut, .unknown)
    }
}
