//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMFetchItemQueueTestComponent: XCTestCase {
    
    let url1 = URL(string:"http://test1.com")!
    let url2 = URL(string:"http://test2.com")!
    var parentItem1: VRMCore.Item!
    var parentItem2: VRMCore.Item!
    
    var candidates: Set<VRMFetchItemQueue.Candidate>!
    
    override func setUp() {
        super.setUp()
        parentItem1 = VRMMockGenerator.createUrlItem()
        parentItem2 = VRMMockGenerator.createVASTItem()
        candidates = Set([
            VRMFetchItemQueue.Candidate(parentItem: parentItem1, url: url1),
            VRMFetchItemQueue.Candidate(parentItem: parentItem2, url: url2)
            ])
    }
    
    func testStartFethcing() {
        let id = VRMCore.ID<VRMCore.Item>()
        let urlItem = VRMMockGenerator.createUrlItem(id: id)
        
        let action1 = VRMCore.startItemFetch(originalItem: urlItem, url: url1)
        var sut = reduce(state: VRMFetchItemQueue.initial, action: action1)
        XCTAssertEqual(sut.candidates.count, 1)
        XCTAssertNotNil(sut.candidates.first { $0.parentItem == urlItem && $0.url == url1 })
        
        
        let action2 = VRMCore.startItemFetch(originalItem: urlItem, url: url2)
        sut = reduce(state: sut, action: action2)
        XCTAssertEqual(sut.candidates.count, 2)
        XCTAssertNotNil(sut.candidates.first { $0.parentItem == urlItem && $0.url == url2 })
    }
    
    func testCleanQueueOnAdRequest() {
        let fullQueue = VRMFetchItemQueue(candidates: candidates)
        let sut = reduce(state: fullQueue,
                         action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertTrue(sut.candidates.isEmpty)
    }
    
    func testCleanQueueOnHardTimeout() {
        let fullQueue = VRMFetchItemQueue(candidates: candidates)
        let sut = reduce(state: fullQueue,
                         action: VRMCore.hardTimeoutReached(items: []))
        XCTAssertTrue(sut.candidates.isEmpty)
    }
    
    func testRemoveItemOnFinishFetching() {
        let fullQueue = VRMFetchItemQueue(candidates: candidates)
        let sut = reduce(state: fullQueue,
                         action: VRMCore.startItemParsing(originalItem: parentItem1,
                                                          vastXML: ""))
        
        XCTAssertFalse(sut.candidates.contains(where: { $0.parentItem == parentItem1 }))
        XCTAssertTrue(sut.candidates.contains(where: { $0.parentItem == parentItem2 }))
    }
    
    func testRemoveItemOnFetchingError() {
        let fullQueue = VRMFetchItemQueue(candidates: candidates)
        let sut = reduce(state: fullQueue,
                         action: VRMCore.failedItemFetch(originalItem: parentItem1))
        
        XCTAssertFalse(sut.candidates.contains(where: { $0.parentItem == parentItem1 }))
        XCTAssertTrue(sut.candidates.contains(where: { $0.parentItem == parentItem2 }))
    }
}
