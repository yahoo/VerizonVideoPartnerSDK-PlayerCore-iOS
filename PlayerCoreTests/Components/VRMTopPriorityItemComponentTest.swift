//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMTopPriorityItemComponentTest: XCTestCase {

    var vastItem: VRMCore.Item!
    var urlItem: VRMCore.Item!
    var group: VRMCore.Group!
    var action: Action!
    var sut: VRMTopPriorityItem!
    
    override func setUp() {
        super.setUp()
        vastItem = VRMMockGenerator.createVASTItem()
        urlItem = VRMMockGenerator.createUrlItem()
        group = VRMCore.Group(items: [vastItem, urlItem])
        action = VRMCore.startGroupProcessing(group: group)
        sut = reduce(state: VRMTopPriorityItem.initial, action: action)
    }
    
    func testReducer() {
        XCTAssertEqual(sut.item, group.items.first)
        
        sut = reduce(state: sut, action: VRMCore.softTimeoutReached())
        
        XCTAssertNil(sut.item)
    }
    
    func adRequest() {
        sut = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertNil(sut.item)
    }
    
}
