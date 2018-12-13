//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class ReplayActionCreatorTestCase: XCTestCase {
    func test() {
        let replay = PlayerCore.replay(currentIndex: 0, prerolls: [], midrolls: []) as? SelectVideoAtIdx
        XCTAssertEqual(replay?.idx, 0)
    }
}
