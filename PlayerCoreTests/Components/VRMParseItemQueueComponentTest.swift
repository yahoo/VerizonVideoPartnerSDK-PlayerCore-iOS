//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMParseItemQueueComponentTest: XCTestCase {

    var parentItem1: VRMCore.Item!
    var parentItem2: VRMCore.Item!
    var vastModel: Ad.VASTModel!
    var candidates: Set<VRMParseItemQueue.Candidate>!
    
    override func setUp() {
        super.setUp()
        parentItem1 = VRMMockGenerator.createUrlItem()
        parentItem2 = VRMMockGenerator.createUrlItem()
        vastModel = VRMMockGenerator.createVASTAdModel()
        candidates = Set([
            VRMParseItemQueue.Candidate(parentItem: parentItem1, vastXML: ""),
            VRMParseItemQueue.Candidate(parentItem: parentItem2, vastXML: ""),
        ])
    }
    
    func testStartParsing() {
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
    
    func testFinishParsing() {
        let fullQueue = VRMParseItemQueue(candidates: candidates)
        
        let sut = reduce(state: fullQueue,
                         action: VRMCore.completeItemParsing(originalItem: parentItem1,
                                                             vastModel: .inline(vastModel)))
        
        XCTAssertTrue(sut.candidates.contains(where: { $0.parentItem == parentItem2 }))
        XCTAssertFalse(sut.candidates.contains(where: { $0.parentItem == parentItem1 }))
    }
    
    func testParsingError() {
        let fullQueue = VRMParseItemQueue(candidates: candidates)
        
        let sut = reduce(state: fullQueue,
                         action: VRMCore.failedItemParse(originalItem: parentItem1))
        
        XCTAssertTrue(sut.candidates.contains(where: { $0.parentItem == parentItem2 }))
        XCTAssertFalse(sut.candidates.contains(where: { $0.parentItem == parentItem1 }))
    }
}
