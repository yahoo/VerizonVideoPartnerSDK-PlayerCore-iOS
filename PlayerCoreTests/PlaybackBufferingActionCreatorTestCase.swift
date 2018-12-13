//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlaybackBufferingActionCreatorTestCase: XCTestCase {
    func testContentBufferingActive() {
        XCTAssertNotNil(updateContentPlaybackBufferingActive() as? ContentPlaybackBufferingActive)
    }
    func testAdBufferingActive() {
        XCTAssertNotNil(updateAdPlaybackBufferingActive() as? AdPlaybackBufferingActive)
    }
    func testContentBufferingInactive() {
        XCTAssertNotNil(updateContentPlaybackBufferingInactive() as? ContentPlaybackBufferingInactive)
    }
    func testAdBufferingInactive() {
        XCTAssertNotNil(updateAdPlaybackBufferingInactive() as? AdPlaybackBufferingInactive)
    }
}
