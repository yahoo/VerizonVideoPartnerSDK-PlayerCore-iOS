//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class SelectVideoAtIndexTestCase: XCTestCase {
    func test() {
        do {
            let select = PlayerCore.selectVideoAtIndex(
                idx: 0,
                prerolls: [2],
                midrolls: [[.init(cuePoint: 5, url: testUrl)]]) as? SelectVideoAtIdx
            XCTAssertEqual(select?.idx, 0)
            XCTAssertEqual(select?.hasPrerollAds, true)
            XCTAssertEqual(select?.midrolls[0].cuePoint, 5)
            XCTAssertEqual(select?.midrolls[0].url, testUrl)
        }
        
        do {
            let select = PlayerCore.selectVideoAtIndex(
                idx: 1,
                prerolls: [],
                midrolls: [
                    [.init(cuePoint: 5, url: testUrl)],
                    [.init(cuePoint: 10, url: testUrl)]
                ]) as? SelectVideoAtIdx
            XCTAssertEqual(select?.idx, 1)
            XCTAssertEqual(select?.hasPrerollAds, false)
            XCTAssertEqual(select?.midrolls.count, 1)
            XCTAssertEqual(select?.midrolls[0].cuePoint, 10)
            XCTAssertEqual(select?.midrolls[0].url, testUrl)
        }
        
        do {
            let select = PlayerCore.selectVideoAtIndex(
                idx: 1,
                prerolls: [],
                midrolls: []) as? SelectVideoAtIdx
            XCTAssertEqual(select?.idx, 1)
            XCTAssertEqual(select?.hasPrerollAds, false)
            XCTAssertEqual(select?.midrolls.isEmpty, true)
        }
    }
}
