//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlaylistComponentTestCase: XCTestCase {
    
    func testReduce() {
        let initial = Playlist(currentIndex: 0)
        var sut = initial
        
        sut = reduce(state: initial, action: Play(time: .init()))
        XCTAssertEqual(sut.currentIndex, 0)
        
        sut = reduce(state: initial, action: Pause())
        XCTAssertEqual(sut.currentIndex, 0)
        
        sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 1, id: .init(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut.currentIndex, 1)
        
        sut = reduce(state: sut, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]), id: UUID(), adVerifications: [], isOpenMeasurementEnabled: true))
        XCTAssertEqual(sut.currentIndex, 1)
    }
}
