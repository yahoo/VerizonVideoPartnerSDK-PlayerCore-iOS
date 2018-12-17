//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMTopPriorityItemComponentTest: XCTestCase {

    func testReducer() {
        let vastItem = VRMMockGenerator.createVASTItem()
        let urlItem = VRMMockGenerator.createUrlItem()
        let group = VRMCore.Group(items: [vastItem, urlItem])
        let action = VRMCore.startGroupProcessing(group: group)
        let sut = reduce(state: VRMTopPriorityItem.initial, action: action)
        
        XCTAssertEqual(sut.item, group.items.first)
    }
    
}
