//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PrevActionCreatorTestCase: XCTestCase {
    func test() {
        let prev = PlayerCore.prev(currentIdx: 1, prerolls: [], midrolls: []) as? SelectVideoAtIdx
        XCTAssertEqual(prev?.idx, 0)
    }
}
