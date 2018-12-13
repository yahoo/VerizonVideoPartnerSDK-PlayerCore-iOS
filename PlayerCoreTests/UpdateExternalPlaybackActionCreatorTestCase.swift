//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class UpdateExternalPlaybackActionCreatorTestCase: XCTestCase {
    func testUpdateExternalPlaybackPossible() {
        XCTAssertNotNil(update(externalPlaybackAllowance: true) as? UpdateExternalPlaybackPossible)
    }
    
    func testUpdateExternalPlaybackImpossible() {
        XCTAssertNotNil(update(externalPlaybackAllowance: false) as? UpdateExternalPlaybackImpossible)
    }
}
