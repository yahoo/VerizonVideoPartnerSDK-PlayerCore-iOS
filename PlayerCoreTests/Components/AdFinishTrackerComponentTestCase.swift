//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdFinishTrackerComponentTestCase: XCTestCase {
    func testReduceOnShowAd() {
        let initial = AdFinishTracker(isForceFinished: true, isSuccessfullyCompleted: true)
        let sut = reduce(state: initial,
                         action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]),
                                        id: UUID(), adVerifications: [], isOpenMeasurementEnabled: true))
        XCTAssertFalse(sut.isForceFinished)
        XCTAssertFalse(sut.isSuccessfullyCompleted)
    }
    
    func testReducerOnMaxShowTime() {
        let initial = AdFinishTracker(isForceFinished: false, isSuccessfullyCompleted: false)
        let sut = reduce(state: initial, action: AdMaxShowTimeout())
        XCTAssertTrue(sut.isForceFinished)
        XCTAssertFalse(sut.isSuccessfullyCompleted)
    }
    
    func testReduceOnShowContent() {
        let initial = AdFinishTracker(isForceFinished: false, isSuccessfullyCompleted: false)
        let sut = reduce(state: initial,
                         action: ShowContent())
        XCTAssertFalse(sut.isForceFinished)
        XCTAssertTrue(sut.isSuccessfullyCompleted)
    }
}
