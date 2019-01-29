//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMParseItemQueueComponentTest: XCTestCase {

    func testReducer() {
        let id = VRMCore.ID<VRMCore.Item>()
        let vastItem = VRMMockGenerator.createVASTItem(id: id)
        let vastXML1 = "vast XML 1"
        let action1 = VRMCore.startItemParsing(originalItem: vastItem, vastXML: vastXML1)
        var sut = reduce(state: VRMParseItemQueue.initial, action: action1)
        XCTAssertEqual(sut.candidates.count, 1)
        XCTAssertNotNil(sut.candidates.first { $0.parentItem == vastItem && $0.vastXML == vastXML1 })
        
        let vastXML2 = "vast XML 2"
        let action2 = VRMCore.startItemParsing(originalItem: vastItem, vastXML: vastXML2)
        sut = reduce(state: sut, action: action2)
        XCTAssertEqual(sut.candidates.count, 2)
        XCTAssertNotNil(sut.candidates.first { $0.parentItem == vastItem && $0.vastXML == vastXML2 })
        
        sut = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertTrue(sut.candidates.isEmpty)
    }
}
