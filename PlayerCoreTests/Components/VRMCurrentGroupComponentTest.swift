//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMCurrentGroupComponentTest: XCTestCase {

    func testDispatch() {
        let group = VRMCore.Group(items: [])
        let sut = reduce(state: VRMCurrentGroup.initial, action: VRMCore.startGroupProcessing(group: group))
        XCTAssertEqual(group, sut.currentGroup)
    }
    
}
