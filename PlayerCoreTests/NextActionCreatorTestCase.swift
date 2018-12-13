//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class NextActionCreatorTestCase: XCTestCase {
    func test() {
        let next = PlayerCore.next(currentIdx: 0,
                                   prerolls: [],
                                   midrolls: []) as? SelectVideoAtIdx
        XCTAssertEqual(next?.idx, 1)
        XCTAssertEqual(next?.hasPrerollAds, false)
        XCTAssertEqual(next?.midrolls.isEmpty, true)
    }
}
