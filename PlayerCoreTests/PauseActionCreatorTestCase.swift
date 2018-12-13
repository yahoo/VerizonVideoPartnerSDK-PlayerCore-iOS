//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PauseActionCreatorTestCase: XCTestCase {
    func test() {
        let method = PlayerCore.pause as () -> Action
        XCTAssertNotNil(method() as? Pause)
    }
}
