//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMCurrentGroupComponentTest: XCTestCase {

    func testReducer() {
        let group = VRMCore.Group(items: [])
        var sut = reduce(state: VRMCurrentGroup.initial, action: VRMCore.startGroupProcessing(group: group))
        XCTAssertEqual(group, sut.currentGroup)
        
        sut = reduce(state: sut, action: VRMCore.finishCurrentGroupProcessing())
        XCTAssertNil(sut.currentGroup)
    }
    
}
