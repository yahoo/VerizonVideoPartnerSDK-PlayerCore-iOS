//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdFinishTrackerComponentTestCase: XCTestCase {
    func testReduceOnShowAd() {
        let initial = AdFinishTracker(isFinished: true)
        let sut = reduce(state: initial,
                         action: ShowAd(creative: .mp4(with: URL(string: "https://test.com")!),
                                        id: UUID(), adVerifications: [], isOpenMeasurementEnabled: true))
        XCTAssertFalse(sut.isFinished)
    }
    
    func testReducerOnMaxShowTime() {
        let initial = AdFinishTracker(isFinished: true)
        let sut = reduce(state: initial, action: AdMaxShowTimeout())
        XCTAssertFalse(sut.isFinished)
    }
    
    func testReduceOnShowContent() {
        let initial = AdFinishTracker(isFinished: false)
        let sut = reduce(state: initial,
                         action: ShowContent())
        XCTAssertTrue(sut.isFinished)
    }
}
