//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class SeekingActionCreatorTestCase: XCTestCase {
    func testStart() {
        XCTAssertNotNil(didStartSeek() as? DidStartSeeking)
    }
    
    func testStop() {
        XCTAssertNotNil(didStopSeek() as? DidStopSeeking)
    }
}

