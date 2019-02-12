//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class DurationComponentTestCase: XCTestCase {
    func testReduce() {
        let initial = Duration(ad: nil, content: nil)
        var sut = initial
        
        sut = reduce(state: sut, action: Play(time: .init()))
        XCTAssertEqual(sut.ad, nil)
        XCTAssertEqual(sut.content, nil)
        
        sut = reduce(state: sut, action: UpdateAdDuration(newDuration: CMTime.zero))
        XCTAssertEqual(sut.ad, CMTime.zero)
        XCTAssertEqual(sut.content, nil)
        
        sut = reduce(state: sut, action: UpdateContentDuration(newDuration: CMTime.zero))
        XCTAssertEqual(sut.ad, CMTime.zero)
        XCTAssertEqual(sut.content, CMTime.zero)
        
        sut = reduce(state: sut, action: ShowContent())
        XCTAssertEqual(sut.ad, nil)
        XCTAssertEqual(sut.content, CMTime.zero)
        
        sut = reduce(state: sut, action: DropAd(id: UUID()))
        XCTAssertEqual(sut.ad, nil)
        XCTAssertEqual(sut.content, CMTime.zero)
        
        sut = reduce(state: sut, action: AdDurationChange(duration: 30 |> toCMTime))
        XCTAssertEqual(sut.ad, 30 |> toCMTime)
        XCTAssertEqual(sut.content, CMTime.zero)
        
        sut = reduce(state: sut, action: SelectVideoAtIdx(idx: 1, id: .init(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut.ad, nil)
        XCTAssertEqual(sut.content, nil)
    }
}
