//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlaybackBufferingComponentTestCase: XCTestCase {
    
    let initial = PlaybackBuffering(content: .unknown, ad: .unknown)
    
    func testReduceContentPlaybackBufferingActive() {
        let sut = reduce(state: initial, action: ContentPlaybackBufferingActive())
        XCTAssertEqual(sut.content, .active)
        XCTAssertEqual(sut.ad, .unknown)
    }
    func testReduceAdPlaybackBufferingActive() {
        let sut = reduce(state: initial, action: AdPlaybackBufferingActive())
        XCTAssertEqual(sut.content, .unknown)
        XCTAssertEqual(sut.ad, .active)
    }
    func testReduceContentPlaybackBufferingInactive() {
        let sut = reduce(state: initial, action: ContentPlaybackBufferingInactive())
        XCTAssertEqual(sut.content, .inactive)
        XCTAssertEqual(sut.ad, .unknown)
    }
    func testReduceAdPlaybackBufferingInactive() {
        let sut = reduce(state: initial, action: AdPlaybackBufferingInactive())
        XCTAssertEqual(sut.content, .unknown)
        XCTAssertEqual(sut.ad, .inactive)
    }
    func testContentPlaybackFailed() {
        class TestError: NSError {}
        var sut = reduce(state: initial, action: ContentPlaybackBufferingActive())
        sut  = reduce(state: sut, action: ContentPlaybackFailed(error: TestError()))
        XCTAssertEqual(sut.content, .unknown)
        XCTAssertEqual(sut.ad, .unknown)
    }
}
