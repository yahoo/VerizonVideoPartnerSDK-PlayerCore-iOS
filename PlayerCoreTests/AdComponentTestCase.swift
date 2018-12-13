//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdComponentTestCase: XCTestCase {
    func testReduceOnShowAdForMp4() {
        let mp4Creative = AdCreative.mp4(with: testUrl)
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         adCreative: .none,
                         currentAd: .empty,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: ShowAd(creative: mp4Creative, id: UUID(), adVerifications: [], isOpenMeasurementEnabled: true))
        guard case .mp4(let adCreative) = sut.adCreative else { return XCTFail("Failed to get mp4 creative") }
        XCTAssertEqual(adCreative.url, testUrl)
        XCTAssertEqual(sut.playedAds.count, 1)
    }
    
    func testReduceOnShowAdForVPAID() {
        let vpaidCreative = AdCreative.vpaid(with: testUrl)
        let initial = Ad(playedAds: [UUID()],
                         midrolls: [],
                         adCreative: .none,
                         currentAd: .empty,
                         currentType: .midroll)
        let sut = reduce(state: initial, action: ShowAd(creative: vpaidCreative, id: UUID(), adVerifications: [], isOpenMeasurementEnabled: true))
        guard case .vpaid(let adCreative) = sut.adCreative else { return XCTFail("Failed to get vpaid creative") }
        XCTAssertEqual(adCreative.url, testUrl)
        XCTAssertEqual(sut.playedAds.count, 2)
    }
    
    func testReduceOnAdPlaybackFailed() {
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         adCreative: .mp4(with: URL(string: "http://test1.com")!),
                         currentAd: .play,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: AdPlaybackFailed(error: .init()))
        guard case .empty = sut.currentAd else { return XCTFail("Current ad state isn't empty") }
        guard case .mp4 = sut.adCreative else { return XCTFail("Ad creative became none") }
    }
    
    func testReduceOnShowContent() {
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         adCreative: .none,
                         currentAd: .empty,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: ShowContent())
        guard case .empty = sut.currentAd else { return XCTFail("Current ad state isn't empty") }
        guard case .none = sut.adCreative else { return XCTFail("Ad creative isn't none") }
    }
    
    func testReduceOnSelectVideoAtIdx() {
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         adCreative: .mp4(with: URL(string: "http://test1.com")!),
                         currentAd: .play,
                         currentType: .midroll)
        let sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 0, id: .init(), hasPrerollAds: true, midrolls: []))
        guard case .empty = sut.currentAd else { return XCTFail("Current ad state isn't empty") }
        guard case .none = sut.adCreative else { return XCTFail("Ad creative isn't none") }
    }
    
    func testReduceDefaultCase() {
        let initial = Ad(playedAds: [],
                         midrolls: [],
                         adCreative: .mp4(with: URL(string: "http://test1.com")!),
                         currentAd: .play,
                         currentType: .preroll)
        let sut = reduce(state: initial, action: Play(time: Date()))
        guard case .play = sut.currentAd else { return XCTFail("Current ad state isn't play") }
        guard case .mp4 = sut.adCreative else { return XCTFail("Ad creative isn't mp4") }
    }
}

extension AdCreative {
    static func mp4(with url: URL) -> AdCreative {
        return AdCreative.mp4(AdCreative.MP4(url: url,
                                             clickthrough: url,
                                             pixels: AdPixels(impression: [],
                                                              error: [],
                                                              clickTracking: [],
                                                              creativeView: [],
                                                              start: [],
                                                              firstQuartile: [],
                                                              midpoint: [],
                                                              thirdQuartile: [],
                                                              complete: [],
                                                              pause: [],
                                                              resume: []),
                                             id: nil,
                                             scalable: false,
                                             maintainAspectRatio: true))
    }
    static func vpaid(with url: URL) -> AdCreative {
        return AdCreative.vpaid(AdCreative.VPAID(url: url,
                                                 adParameters: nil,
                                                 clickthrough: url,
                                                 pixels: AdPixels(impression: [],
                                                                  error: [],
                                                                  clickTracking: [],
                                                                  creativeView: [],
                                                                  start: [],
                                                                  firstQuartile: [],
                                                                  midpoint: [],
                                                                  thirdQuartile: [],
                                                                  complete: [],
                                                                  pause: [],
                                                                  resume: []),
                                                 id: nil))
    }
}
