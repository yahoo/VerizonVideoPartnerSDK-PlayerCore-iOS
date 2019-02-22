//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdFinishTrackerComponentTestCase: XCTestCase {
    
    func testOnAdRequest() {
        let url = URL(string: "http://test.com")!
        let initial = AdFinishTracker.successfullyCompleted
        
        var sut = reduce(state: initial,
                         action: VRMCore.AdRequest(url: url, id: UUID(), type: .preroll))
        
        XCTAssertEqual(sut, .unknown)
        
        sut = reduce(state: initial,
                     action: VRMCore.AdRequest(url: url, id: UUID(), type: .preroll))
        
        XCTAssertEqual(sut, .unknown)
    }
    
    func testReduceOnShowAd() {
        let initial = AdFinishTracker.unknown
        var sut = reduce(state: initial,
                         action: ShowMP4Ad(creative: AdCreative.mp4(with: testUrl), id: UUID()))
        XCTAssertEqual(sut, .unknown)
        
        sut = reduce(state: initial,
                     action: ShowVPAIDAd(creative: AdCreative.vpaid(with: testUrl), id: UUID()))
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
