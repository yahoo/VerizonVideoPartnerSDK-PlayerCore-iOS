//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMFetchItemQueueTestComponent: XCTestCase {

    func testReducer() {
        let id = VRMCore.ID<VRMCore.Item>()
        let urlItem = VRMMockGenerator.createUrlItem(id: id)
        let url1 = URL(string:"http://test1.com")!
        let action1 = VRMCore.startItemFetch(originalItem: urlItem, url: url1)
        var sut = reduce(state: VRMFetchItemQueue.initial, action: action1)
        XCTAssertEqual(sut.candidates.count, 1)
        XCTAssertNotNil(sut.candidates.first { $0.parentItem == urlItem && $0.url == url1 })
        
        let url2 = URL(string:"http://test2.com")!
        let action2 = VRMCore.startItemFetch(originalItem: urlItem, url: url2)
        sut = reduce(state: sut, action: action2)
        XCTAssertEqual(sut.candidates.count, 2)
        XCTAssertNotNil(sut.candidates.first { $0.parentItem == urlItem && $0.url == url2 })
    }
}
