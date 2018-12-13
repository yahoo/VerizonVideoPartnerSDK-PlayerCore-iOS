//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VPAIDActionCreatorTestCase: XCTestCase {
    func testActionCreator() {
        let url = URL(string: "https://example.com")!
        XCTAssertNotNil(createAction(from: .AdNotSupported) as? AdNotSupported)
        XCTAssertNotNil(createAction(from: .AdLoaded) as? AdLoaded)
        XCTAssertNotNil(createAction(from: .AdStarted) as? AdStarted)
        XCTAssertNotNil(createAction(from: .AdStopped) as? AdStopped)
        XCTAssertNotNil(createAction(from: .AdSkipped) as? AdSkipped)
        XCTAssertNotNil(createAction(from: .AdPaused) as? AdPaused)
        XCTAssertNotNil(createAction(from: .AdResumed) as? AdResumed)
        XCTAssertNotNil(createAction(from: .AdImpression) as? AdImpression)
        XCTAssertNotNil(createAction(from: .AdVideoStart) as? AdVideoStart)
        XCTAssertNotNil(createAction(from: .AdVideoFirstQuartile) as? AdVideoFirstQuartile)
        XCTAssertNotNil(createAction(from: .AdVideoMidpoint) as? AdVideoMidpoint)
        XCTAssertNotNil(createAction(from: .AdVideoThirdQuartile) as? AdVideoThirdQuartile)
        XCTAssertNotNil(createAction(from: .AdVideoComplete) as? AdVideoComplete)
        XCTAssertNotNil(createAction(from: .AdUserAcceptInvitation) as? AdUserAcceptInvitation)
        XCTAssertNotNil(createAction(from: .AdUserMinimize) as? AdUserMinimize)
        XCTAssertNotNil(createAction(from: .AdUserClose) as? AdUserClose)
        XCTAssertNotNil(createAction(from: .AdClickThru("")) as? AdClickThru)
        XCTAssertNotNil(createAction(from: .AdError(NSError(domain: "", code: 901))) as? AdError)
        XCTAssertNotNil(createAction(from: .AdDurationChange(1)) as? AdDurationChange)
        XCTAssertNotNil(createAction(from: .AdCurrentTimeChanged(1)) as? AdCurrentTimeChanged)
        XCTAssertNotNil(createAction(from: .AdVolumeChange(1)) as? AdVolumeChange)
        XCTAssertNotNil(createAction(from: .AdWindowOpen(url)) as? AdWindowOpen)
        XCTAssertNotNil(createAction(from: .AdUniqueEventAbuse(name: "", value: "")) as? AdUniqueEventAbuse)
        XCTAssertNotNil(createAction(from: .AdJSEvaluationFailed(NSError(domain: "", code: 901))) as? AdJavaScriptEvaluationError)
    }
}
