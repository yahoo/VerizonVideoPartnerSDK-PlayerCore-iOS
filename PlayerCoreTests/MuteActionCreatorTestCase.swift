//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class MuteActionCreatorTestCase: XCTestCase {
    func test() {
        XCTAssertNotNil(PlayerCore.mute() as? PlayerMute)
        XCTAssertNotNil(PlayerCore.unmute() as? PlayerUnmute)
    }
}
