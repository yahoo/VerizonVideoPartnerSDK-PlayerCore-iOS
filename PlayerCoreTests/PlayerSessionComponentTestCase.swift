//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlayerSessionComponentTestCase: XCTestCase {
    func testReduceOnSelectVideoAtIdx() {
        let initial = PlayerSession(id: UUID(),
                                    creationTime: Date(),
                                    isCompleted: false,
                                    isStarted: false)
        let sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 1,
                                                                  id: UUID(),
                                                                  hasPrerollAds: true,
                                                                  midrolls: []))
        XCTAssertTrue(sut.isStarted)
    }
    
    func testReduceOnCompletePlayerSession() {
        let initial = PlayerSession(id: UUID(),
                                    creationTime: Date(),
                                    isCompleted: false,
                                    isStarted: false)
        let sut = reduce(state: initial, action: CompletePlayerSession())
        XCTAssertTrue(sut.isCompleted)
    }
    
    func testReduceOnPlay() {
        let initial = PlayerSession(id: UUID(),
                                    creationTime: Date(),
                                    isCompleted: false,
                                    isStarted: false)
        let sut = reduce(state: initial, action: Play(time: Date()))
        XCTAssertTrue(sut.isStarted)
    }
    
    func testReduceOnContentDidPlay() {
        let initial = PlayerSession(id: UUID(),
                                    creationTime: Date(),
                                    isCompleted: false,
                                    isStarted: false)
        let sut = reduce(state: initial, action: ContentDidPlay())
        XCTAssertTrue(sut.isStarted)
    }
}
