//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMCurrentGroupComponentTest: XCTestCase {

    func testReducer() {
        let group = VRMCore.Group(items: [])
        let sut = reduce(state: VRMCurrentGroup.initial, action: VRMCore.startGroupProcessing(group: group))
        XCTAssertEqual(group, sut.currentGroup)
        
        let afterFinishGroup = reduce(state: sut, action: VRMCore.finishCurrentGroupProcessing())
        XCTAssertNil(afterFinishGroup.currentGroup)
        
        let afterAdRequest = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertNil(afterAdRequest.currentGroup)
    }
    
}
