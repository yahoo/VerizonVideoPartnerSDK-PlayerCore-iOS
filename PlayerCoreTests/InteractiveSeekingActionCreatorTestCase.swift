//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class InteractiveSeekingActionCreatorTestCase: XCTestCase {
    func testBegin() {
        XCTAssertNotNil(startInteractiveSeeking(progress: 0, duration: CMTime.zero) as? StartInteractiveSeeking)
    }
    
    func testEnd() {
        XCTAssertNotNil(stopInteractiveSeeking(progress: 0, duration: CMTime.zero) as? StopInteractiveSeeking)
    }
}
