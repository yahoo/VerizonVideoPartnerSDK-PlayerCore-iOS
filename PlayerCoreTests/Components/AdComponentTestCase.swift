//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdComponentTestCase: XCTestCase {
    
    func testDismissAd() {
        let id = UUID()
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         mp4AdCreative: nil,
                         vpaidAdCreative: nil,
                         currentAd: .empty,
                         currentType: .preroll)
        
        var sut = reduce(state: initial, action: dropAd(id: id))
        XCTAssertEqual(sut.playedAds.count, 1)
        
        sut = reduce(state: initial, action: VRMCore.adResponseFetchFailed(requestID: id))
        XCTAssertEqual(sut.playedAds.count, 1)
        
        sut = reduce(state: initial, action: VRMCore.noGroupsToProcess(id: id))
        XCTAssertEqual(sut.playedAds.count, 1)
        
        sut = reduce(state: initial, action: VRMCore.maxSearchTimeoutReached(requestID: id))
        XCTAssertEqual(sut.playedAds.count, 1)
    }
    
    func testReduceOnShowAdForMp4() {
        let mp4AdCreative = AdCreative.mp4(with: testUrl)
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         mp4AdCreative: nil,
                         vpaidAdCreative: nil,
                         currentAd: .empty,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: ShowAd(creative: .mp4([mp4AdCreative]), id: UUID(), adVerifications: []))
        XCTAssertNil(sut.vpaidAdCreative)
        XCTAssertEqual(mp4AdCreative, sut.mp4AdCreative)
        XCTAssertEqual(sut.currentAd, .play)
        XCTAssertEqual(sut.playedAds.count, 1)
    }
    
    func testReduceOnShowAdForVPAID() {
        let vpaidAdCreative = AdCreative.vpaid(with: testUrl)
        let initial = Ad(playedAds: [UUID()],
                         midrolls: [],
                         mp4AdCreative: nil,
                         vpaidAdCreative: nil,
                         currentAd: .empty,
                         currentType: .midroll)
        let sut = reduce(state: initial, action: ShowAd(creative: .vpaid([vpaidAdCreative]), id: UUID(), adVerifications: []))
        XCTAssertNil(sut.mp4AdCreative)
        XCTAssertEqual(vpaidAdCreative, sut.vpaidAdCreative)
        XCTAssertEqual(sut.currentAd, .play)
        XCTAssertEqual(sut.playedAds.count, 2)
    }
    
    func testReduceOnANewShowMP4Action() {
        let mp4AdCreative = AdCreative.mp4(with: testUrl)
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         mp4AdCreative: nil,
                         vpaidAdCreative: nil,
                         currentAd: .empty,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: ShowMP4Ad(creative: mp4AdCreative, id: UUID()))
        XCTAssertNil(sut.vpaidAdCreative)
        XCTAssertEqual(mp4AdCreative, sut.mp4AdCreative)
        XCTAssertEqual(sut.currentAd, .play)
        XCTAssertEqual(sut.playedAds.count, 1)
    }
    
    func testReduceOnANewShowVPAIDAction() {
        let vpaidAdCreative = AdCreative.vpaid(with: testUrl)
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         mp4AdCreative: nil,
                         vpaidAdCreative: nil,
                         currentAd: .empty,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: ShowVPAIDAd(creative: vpaidAdCreative, id: UUID()))
        XCTAssertNil(sut.mp4AdCreative)
        XCTAssertEqual(vpaidAdCreative, sut.vpaidAdCreative)
        XCTAssertEqual(sut.currentAd, .play)
        XCTAssertEqual(sut.playedAds.count, 1)
    }
    
    func testReduceOnAdPlaybackFailed() {
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         mp4AdCreative: AdCreative.mp4(with: testUrl),
                         vpaidAdCreative: nil,
                         currentAd: .play,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: AdPlaybackFailed(error: .init()))
        XCTAssertEqual(sut.currentAd, .empty)
        XCTAssertNotNil(sut.mp4AdCreative)
    }
    
    func testReduceOnSelectVideoAtIdx() {
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         mp4AdCreative: AdCreative.mp4(with: testUrl),
                         vpaidAdCreative: nil,
                         currentAd: .play,
                         currentType: .midroll)
        let sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 0, id: .init(), hasPrerollAds: true, midrolls: []))
        XCTAssertEqual(sut.currentAd, .empty)
        XCTAssertNil(sut.mp4AdCreative)
    }
    
    func testReduceDefaultCase() {
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         mp4AdCreative: AdCreative.mp4(with: testUrl),
                         vpaidAdCreative: nil,
                         currentAd: .play,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: Play(time: Date()))
        XCTAssertEqual(sut.currentAd, .play)
        XCTAssertNotNil(sut.mp4AdCreative)
    }
}

extension AdCreative {
    static func mp4(with url: URL) -> AdCreative.MP4 {
        return AdCreative.MP4(url: url,
                              clickthrough: url,
                              pixels: AdPixels(),
                              id: nil,
                              width: 320,
                              height: 240,
                              scalable: false,
                              maintainAspectRatio: true)
    }
    static func vpaid(with url: URL) -> AdCreative.VPAID {
        return AdCreative.VPAID(url: url,
                                adParameters: nil,
                                clickthrough: url,
                                pixels: AdPixels(),
                                id: nil)
    }
}
