//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AirPlayComponentTestCase: XCTestCase {
    let initial = AirPlay.restricted
    func testReduceOnUpdateExternalPlayback() {
        var sut = reduce(state: initial, action: UpdateExternalPlaybackPossible())
        XCTAssertEqual(sut, .inactive)
        
        sut = reduce(state: sut, action: UpdateExternalPlaybackImpossible())
        XCTAssertEqual(sut, .disabled)
        
        sut = reduce(state: sut, action: UpdateExternalPlaybackActive())
        XCTAssertEqual(sut, .active)
        
        sut = reduce(state: sut, action: UpdateExternalPlaybackInactive())
        XCTAssertEqual(sut, .disabled)
    }
}

