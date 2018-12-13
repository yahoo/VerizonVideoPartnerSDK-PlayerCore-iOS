//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class ContentFullScreenTestCase: XCTestCase {
    
    func testReduceOnFullScreen() {
        let initial = ContentFullScreen.active
        let sut = reduce(state: initial, action: ContentFullScreenToggleAction())
        XCTAssertEqual(sut, ContentFullScreen.inactive)
    }
    
    func testReduceOnNotFullScreen() {
        let initial = ContentFullScreen.inactive
        let sut = reduce(state: initial, action: ContentFullScreenToggleAction())
        XCTAssertEqual(sut, ContentFullScreen.active)
    }
    
    func testReduceOnOtherActions() {
        let initial = ContentFullScreen.inactive
        let sut = reduce(state: initial, action: Play(time: .init()))
        XCTAssertEqual(sut, ContentFullScreen.inactive)
    }
}

