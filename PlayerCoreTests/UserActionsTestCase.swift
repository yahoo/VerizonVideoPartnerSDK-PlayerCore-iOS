//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class UserActionsTestCase: XCTestCase {
    let initial = UserActions.nothing
    func testReduceUserActionsComponent() {
        var sut = reduce(state: .nothing, action: Play(time: Date()))
        XCTAssertEqual(sut, .play)
        
        sut = reduce(state: sut, action: UpdateAdStreamRate(time: Date(), rate: true))
        XCTAssertEqual(sut, .nothing)
        
        sut = reduce(state: sut, action: Pause())
        XCTAssertEqual(sut, .pause)
        
        sut = reduce(state: sut, action: UpdateAdStreamRate(time: Date(), rate: false))
        XCTAssertEqual(sut, .nothing)
    }
}

