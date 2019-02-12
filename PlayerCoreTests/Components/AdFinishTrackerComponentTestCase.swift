//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdFinishTrackerComponentTestCase: XCTestCase {
    func testReduceOnShowAd() {
        let initial = AdFinishTracker.unknown
        let sut = reduce(state: initial,
                         action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]),
                                        id: UUID(), adVerifications: []))
        XCTAssertEqual(sut, .unknown)
    }
    
    func testReducerOnMaxShowTime() {
        let initial = AdFinishTracker.unknown
        let sut = reduce(state: initial, action: AdMaxShowTimeout())
        XCTAssertEqual(sut, .forceFinished)
    }
    
    func testReduceOnShowContent() {
        let initial = AdFinishTracker.unknown
        let sut = reduce(state: initial,
                         action: ShowContent())
        XCTAssertEqual(sut, .successfullyCompleted)
    }
    func testReduceOnSkipAd() {
        let initial = AdFinishTracker.unknown
        let sut = reduce(state: initial,
                         action: SkipAd())
        XCTAssertEqual(sut, .skipped)
    }
}
