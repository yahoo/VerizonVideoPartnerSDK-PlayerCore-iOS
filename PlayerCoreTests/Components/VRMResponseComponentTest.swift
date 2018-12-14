//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMResponseComponentTest: XCTestCase {
    func testReducer() {
        
        let initial: VRMResponse? = nil
        let action = VRMCore.VRMResponseAction(transactionId: "transactionId",
                                              slot: "slot",
                                              groups: [])
        let sut = reduce(state: initial, action: action)
        XCTAssertEqual(sut?.transactionId, "transactionId")
        XCTAssertEqual(sut?.slot, "slot")
    }
}
