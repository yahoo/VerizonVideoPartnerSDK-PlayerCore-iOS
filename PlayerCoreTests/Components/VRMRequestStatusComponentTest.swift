//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMRequestStatusComponentTest: XCTestCase {

    func testReducer() {
        let initial = VRMRequestStatus.initial
        let url = URL(string: "test")!
        let uuid = UUID()
        let sut = reduce(state: initial, action: VRMCore.adRequest(url: url, id: uuid, type: .preroll))
        
        XCTAssertEqual(sut.requestsFired, 1)
        if let request = sut.request {
            XCTAssertEqual(request.id, uuid)
            XCTAssertEqual(request.url, url)
        } else {
            XCTFail()
        }
    }
}
