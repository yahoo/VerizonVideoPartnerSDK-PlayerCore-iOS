//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMFetchItemQueueTestComponent: XCTestCase {

    func testReducer() {
        let id = VRMCore.ID<VRMCore.Item>()
        let urlItem = VRMMockGenerator.createUrlItem(id: id)
        let url = URL(string:"http://test.com")!
        let action = VRMCore.startItemFetch(originalItem: urlItem, url: url)
        let sut = reduce(state: VRMFetchItemQueue.initial, action: action)
        XCTAssertEqual(sut.candidates.count, 1)
        XCTAssertNotNil(sut.candidates.first { $0.parentItem == urlItem && $0.url == url })
    }

}
