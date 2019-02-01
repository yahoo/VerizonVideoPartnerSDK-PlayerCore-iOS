//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class CurrentTimeComponentTestCase: XCTestCase {
    let initial = CurrentTime(content: .init(time: 5 |> toCMTime, isSeekInProgress: false),
                              ad: 10 |> toCMTime)
    
    func testReduceOnUpdateContentCurrentTime() {
        let sut = reduce(state: initial,
                         action: UpdateContentCurrentTime(newTime: 20 |> toCMTime, currentDate: Date()))
        XCTAssertEqual(sut.content?.time, 20 |> toCMTime)
        XCTAssertEqual(sut.ad, 10 |> toCMTime)
    }
    
    func testReduceOnUpdateAdCurrentTime() {
        let sut = reduce(state: initial,
                         action: UpdateAdCurrentTime(newTime: 20 |> toCMTime))
        XCTAssertEqual(sut.content?.time, 5 |> toCMTime)
        XCTAssertEqual(sut.ad, 20 |> toCMTime)
    }
    
    func testReduceOnShowContent() {
        let sut = reduce(state: initial, action: ShowContent())
        XCTAssertEqual(sut.content?.time, 5 |> toCMTime)
        XCTAssertEqual(sut.ad, 10 |> toCMTime)
    }
    
    func testSeekToTime() {
        let sut = reduce(state: initial, action: SeekToTime(newTime: 12 |> toCMTime))
        XCTAssertEqual(sut.content?.time, 12 |> toCMTime)
        XCTAssertEqual(sut.ad, 10 |> toCMTime)
    }
    
    func testBeginInteractiveSeeking() {
        let newTime = CMTime(seconds: 10, preferredTimescale: 600)
        let sut = reduce(state: initial, action: StartInteractiveSeeking(newTime: newTime))
        XCTAssertEqual(sut.content?.time, newTime)
        XCTAssertEqual(sut.ad, initial.ad)
    }
    
    func testEndInteractiveSeeking() {
        let newTime = CMTime(seconds: 10, preferredTimescale: 600)
        let sut = reduce(state: initial, action: StopInteractiveSeeking(newTime: newTime))
        XCTAssertEqual(sut.content?.time, newTime)
        XCTAssertEqual(sut.ad, initial.ad)
    }
    
    func testReduceOnShowAd() {
        let sut = reduce(state: initial, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]), id: UUID(), adVerifications: [], isOpenMeasurementEnabled: true))
        XCTAssertEqual(sut.content?.time, 5 |> toCMTime)
        XCTAssertEqual(sut.ad, CMTime.zero)
    }
    
    func testReduceOnSelectVideoAtIdx() {
        let sut = reduce(state: initial, action: SelectVideoAtIdx(idx: 1, id: .init(), hasPrerollAds: false, midrolls: []))
        XCTAssertEqual(sut.content?.time, CMTime.zero)
        XCTAssertEqual(sut.ad, CMTime.zero)
    }
    
    func testReduceOnIgnoredAction() {
        let sut = reduce(state: initial, action: Play(time: .init()))
        XCTAssertEqual(sut.content?.time, 5 |> toCMTime)
        XCTAssertEqual(sut.ad, 10 |> toCMTime)
    }
    
    func testReduceOnStartSeek() {
        var sut = reduce(state: initial, action: DidStartSeeking())
        XCTAssertEqual(sut.content?.isSeekInProgress, true)
        
        let newCurrentTime = 20 |> toCMTime
        
        sut = reduce(state: sut,
                     action: UpdateContentCurrentTime(newTime: newCurrentTime, currentDate: Date()))
        XCTAssertEqual(sut.content?.time, initial.content?.time)
    }
    
    func testReduceOnStopSeek() {
        var sut = reduce(state: initial, action: DidStopSeeking())
        XCTAssertEqual(sut.content?.isSeekInProgress, false)
        
        let newCurrentTime = 20 |> toCMTime
        
        sut = reduce(state: sut,
                     action: UpdateContentCurrentTime(newTime: newCurrentTime, currentDate: Date()))
        XCTAssertEqual(sut.content?.time, newCurrentTime)
        
        sut = reduce(state: sut,
                     action: UpdateAdCurrentTime(newTime: newCurrentTime))
        XCTAssertEqual(sut.ad, newCurrentTime)
    }
    
    func testReduceOnRemainingTimeChanged() {
        let sut = reduce(state: initial, action: AdCurrentTimeChanged(newTime: 15 |> toCMTime))
        XCTAssertEqual(sut.content?.time, 5 |> toCMTime)
        XCTAssertEqual(sut.ad, 15 |> toCMTime)
    }
    
    func testReduceOnSeekToTime() {
        let sut = reduce(state: CurrentTime(content: nil,
                                            ad: 10 |> toCMTime),
                         action: SeekToTime(newTime: 5 |> toCMTime))
        XCTAssertEqual(sut.content?.time, 5 |> toCMTime)
        XCTAssertEqual(sut.ad, 10 |> toCMTime)
    }
}
