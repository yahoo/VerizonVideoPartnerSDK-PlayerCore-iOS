//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class ScheduledVRMItemsComponentTest: XCTestCase {

    func testStartGroupAndCleanOnAdRequest() {
        let urlItem = VRMMockGenerator.createUrlItem()
        let vastItem = VRMMockGenerator.createVASTItem()
        let group = VRMCore.Group(items: [urlItem, vastItem])
        
        var sut = ScheduledVRMItems.initial
        sut = reduce(state: sut, action: PlayerCore.VRMCore.startGroupProcessing(group: group))

        XCTAssertTrue(sut.items[urlItem]?.contains(where: { $0.source == urlItem.source }) == true)
        XCTAssertTrue(sut.items[vastItem]?.contains(where: { $0.source == vastItem.source }) == true)
        
        let otherUrlItem = VRMMockGenerator.createUrlItem()
        let nextGroup = VRMCore.Group(items: [otherUrlItem])
        
        sut = reduce(state: sut, action: PlayerCore.VRMCore.startGroupProcessing(group: nextGroup))
        XCTAssertTrue(sut.items[otherUrlItem]?.contains(where: { $0.source == otherUrlItem.source }) == true)
        
        XCTAssertEqual(sut.items.count, 3)
        
        sut = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertTrue(sut.items.isEmpty)
    }
    
    func testWrapperProcessing() {
        let urlItem = VRMMockGenerator.createUrlItem()
        var sut = ScheduledVRMItems(items: [urlItem: Set(arrayLiteral: ScheduledVRMItems.Candidate(source: urlItem.source))])
        
        sut = reduce(state: sut, action: VRMCore.unwrapItem(item: urlItem, url: URL(string: "http://test.com")!))
        
        XCTAssertTrue(sut.items[urlItem]?.count == 2)
    }
}
