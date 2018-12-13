//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class UpdateExternalPlaybackStatusActionCreatorTestCase: XCTestCase {
    func testUpdateExternalPlaybackStatusActive() {
        XCTAssertNotNil(update(externalPlaybackStatus: true) as? UpdateExternalPlaybackActive)
    }
    
    func testUpdateExternalPlaybackStatusInactive() {
        XCTAssertNotNil(update(externalPlaybackStatus: false) as? UpdateExternalPlaybackInactive)
    }
}
