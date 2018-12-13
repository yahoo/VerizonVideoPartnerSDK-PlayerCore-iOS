//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AverageBitrateComponentTestCase: XCTestCase {
    let initial = AverageBitrate(content: nil, ad: nil)
    
    func testReduceWithUpdateContentAverageBitrate() {
        let sut = reduce(state: initial, action: UpdateContentAverageBitrate(bitrate: 100))
        XCTAssertEqual(sut.content, 100)
        XCTAssertNil(sut.ad)
    }
    
    func testReduceWithUpdateAverageBitrate() {
        let sut = reduce(state: initial, action: UpdateAdAverageBitrate(bitrate: 100))
        XCTAssertNil(sut.content)
        XCTAssertEqual(sut.ad, 100)
    }

    func testReduceWithSelectVideoAtIndex() {
        let sut = reduce(state: AverageBitrate(content: 50, ad: 50),
                         action: SelectVideoAtIdx(idx: 1, id: .init(), hasPrerollAds: false, midrolls: []))
        XCTAssertNil(sut.content)
        XCTAssertNil(sut.ad)
    }
    
    func testReduceOtherAction() {
        let sut = reduce(state: initial, action: Play(time: .init()))
        XCTAssertNil(sut.content)
        XCTAssertNil(sut.ad)
    }
}
