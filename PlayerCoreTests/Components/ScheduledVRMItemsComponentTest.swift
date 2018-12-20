//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class ScheduledVRMItemsComponentTest: XCTestCase {

    func testStartFirstGroup() {
        let group = VRMCore.Group(items: [VRMMockGenerator.createUrlItem(), VRMMockGenerator.createUrlItem()])
        var sut = ScheduledVRMItems.initial
        sut = reduce(state: sut, action: PlayerCore.VRMCore.startGroupProcessing(group: group))
        
        XCTAssertTrue(sut.items.isSubset(of: group.items))
    }
}
