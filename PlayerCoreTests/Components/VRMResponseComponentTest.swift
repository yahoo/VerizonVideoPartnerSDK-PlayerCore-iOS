//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMResponseComponentTest: XCTestCase {
    func testReducer() {
        
        let initial: VRMResponse? = nil
        let responseAction = VRMCore.VRMResponseAction(transactionId: "transactionId",
                                              slot: "slot",
                                              groups: [])
        let requestAction = VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll)
        
        let afterResponseAction = reduce(state: initial, action: responseAction)
        XCTAssertEqual(afterResponseAction?.transactionId, "transactionId")
        XCTAssertEqual(afterResponseAction?.slot, "slot")
        
        let afterRequstAction = reduce(state: initial, action: requestAction)
        XCTAssertNil(afterRequstAction)
    }
}
