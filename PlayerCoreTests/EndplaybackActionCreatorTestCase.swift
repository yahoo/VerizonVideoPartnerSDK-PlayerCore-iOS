//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class EndplaybackActionCreatorTestCase: XCTestCase {
    
    func testContentEndPlaybackToNextVideo() {
        let sut = PlayerCore.contentEndPlayback(currentIdx: 0, count: 2, prerolls: [], midrolls: []) as? SelectVideoAtIdx
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.idx, 1)
    }
    func testContentEndPlaybackToCompletePlaybackSession() {
        let sut = PlayerCore.contentEndPlayback(currentIdx: 1, count: 2, prerolls: [], midrolls: []) as? CompletePlaybackSession
        
        XCTAssertNotNil(sut)
    }
    
    func testAdEndPlaybackWithouAds() {
        let sut = PlayerCore.adEndPlayback() as? ShowContent
        XCTAssertNotNil(sut)
    }
}
