//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMGroupsQueueComponentTest: XCTestCase {

    let firstGroup = VRMCore.Group(items: [])
    let secondGroup = VRMCore.Group(items: [])
    
    func testResponseRequest() {
        let setResponseAction = VRMCore.adResponse(transactionId: "transactionId",
                                                   slot: "slot",
                                                   groups: [firstGroup, secondGroup])
        var sut = reduce(state: VRMGroupsQueue.initial, action: setResponseAction)
        
        XCTAssertEqual(sut.groupsQueue, [firstGroup, secondGroup])
        
        sut = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertTrue(sut.groupsQueue.isEmpty)
    }
    
    func testStartProcessingGroups() {
        var sut = reduce(state: VRMGroupsQueue(groupsQueue: [firstGroup, secondGroup]),
                         action: VRMCore.startGroupProcessing(group: firstGroup))
        
        XCTAssertEqual(sut.groupsQueue, [secondGroup])
        
        sut = reduce(state: sut,
                     action: VRMCore.startGroupProcessing(group: secondGroup))
        
        XCTAssertTrue(sut.groupsQueue.isEmpty)
        
        sut = reduce(state: sut,
                     action: VRMCore.startGroupProcessing(group: secondGroup))
        
        XCTAssertTrue(sut.groupsQueue.isEmpty)
    }
}
