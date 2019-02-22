//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class RateComponentTestCase: XCTestCase {
    func testReduce() {
        let initial = Rate(contentRate: .init(player: false,
                                              stream: false),
                           adRate: .init(player: false,
                                         stream: false),
                           isAttachedToViewPort: false,
                           currentKind: .content)
        var sut = initial
        
        sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 0, id: .init(), hasPrerollAds: true, midrolls: []))
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .ad)
  
        sut = reduce(state: sut, action: Play(time: .init()))
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: ShowContent())
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: ShowContent())
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: Play(time: .init()))
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: Pause())
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: ShowMP4Ad(creative: AdCreative.mp4(with: testUrl), id: UUID()))
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: ShowMP4Ad(creative: AdCreative.mp4(with: testUrl), id: UUID()))
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: Play(time: .init()))
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: UpdateAdStreamRate(time: Date(), rate: true))
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, true)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: UpdateAdStreamRate(time: Date(), rate: false))
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: ShowContent())
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: UpdateContentStreamRate(time: Date(), rate: true))
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, true)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: UpdateContentStreamRate(time: Date(), rate: false))
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: SelectVideoAtIdx(idx: 0, id: .init(), hasPrerollAds: false, midrolls: []))
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: AttachToViewport(dimensions: CGSize(width: 100, height: 100)))
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: DetachFromViewport())
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: ContentDidPause())
        
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, false)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: AttachToViewport(dimensions: CGSize(width: 100, height: 100)))
        sut = reduce(state: sut, action: ContentDidPause())
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .content)
        
        sut = reduce(state: sut, action: ShowMP4Ad(creative: AdCreative.mp4(with: testUrl), id: UUID()))
        sut = reduce(state: sut, action: AdDidPause())
        
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: ShowMP4Ad(creative: AdCreative.mp4(with: testUrl), id: UUID()))
        sut = reduce(state: sut, action: AdPaused())
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: AdResumed())
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, true)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: AdDidPause())
        sut = reduce(state: sut, action: UpdateAdStreamRate(time: Date(), rate: false))
        sut = reduce(state: sut, action: DidHideAdClickthrough(isAdVPAID: false))
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: AdPaused())
        sut = reduce(state: sut, action: UpdateAdStreamRate(time: Date(), rate: false))
        sut = reduce(state: sut, action: DidHideAdClickthrough(isAdVPAID: true))
        XCTAssertEqual(sut.contentRate.player, false)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, true)
        XCTAssertEqual(sut.adRate.stream, true)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .ad)
        
        sut = reduce(state: sut, action: SkipAd())
        XCTAssertEqual(sut.contentRate.player, true)
        XCTAssertEqual(sut.contentRate.stream, false)
        XCTAssertEqual(sut.adRate.player, false)
        XCTAssertEqual(sut.adRate.stream, false)
        XCTAssertEqual(sut.isAttachedToViewPort, true)
        XCTAssertEqual(sut.currentKind, .content)
    }
}
