//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VPAIDActionCreatorTestCase: XCTestCase {
    func testActionCreator() {
        let url = URL(string: "https://example.com")!
        XCTAssertNotNil(createAction(from: .AdNotSupported) as? VPAIDActions.AdNotSupported)
        XCTAssertNotNil(createAction(from: .AdLoaded) as? VPAIDActions.AdLoaded)
        XCTAssertNotNil(createAction(from: .AdStarted) as? VPAIDActions.AdStarted)
        XCTAssertNotNil(createAction(from: .AdStopped) as? VPAIDActions.AdStopped)
        XCTAssertNotNil(createAction(from: .AdSkipped) as? VPAIDActions.AdSkipped)
        XCTAssertNotNil(createAction(from: .AdPaused) as? VPAIDActions.AdPaused)
        XCTAssertNotNil(createAction(from: .AdResumed) as? VPAIDActions.AdResumed)
        XCTAssertNotNil(createAction(from: .AdImpression) as? VPAIDActions.AdImpression)
        XCTAssertNotNil(createAction(from: .AdVideoStart) as? VPAIDActions.AdVideoStart)
        XCTAssertNotNil(createAction(from: .AdVideoFirstQuartile) as? VPAIDActions.AdVideoFirstQuartile)
        XCTAssertNotNil(createAction(from: .AdVideoMidpoint) as? VPAIDActions.AdVideoMidpoint)
        XCTAssertNotNil(createAction(from: .AdVideoThirdQuartile) as? VPAIDActions.AdVideoThirdQuartile)
        XCTAssertNotNil(createAction(from: .AdVideoComplete) as? VPAIDActions.AdVideoComplete)
        XCTAssertNotNil(createAction(from: .AdUserAcceptInvitation) as? VPAIDActions.AdUserAcceptInvitation)
        XCTAssertNotNil(createAction(from: .AdUserMinimize) as? VPAIDActions.AdUserMinimize)
        XCTAssertNotNil(createAction(from: .AdUserClose) as? VPAIDActions.AdUserClose)
        XCTAssertNotNil(createAction(from: .AdClickThru("")) as? VPAIDActions.AdClickThru)
        XCTAssertNotNil(createAction(from: .AdError(NSError(domain: "", code: 901))) as? VPAIDActions.AdError)
        XCTAssertNotNil(createAction(from: .AdDurationChange(1)) as? VPAIDActions.AdDurationChange)
        XCTAssertNotNil(createAction(from: .AdCurrentTimeChanged(1)) as? VPAIDActions.AdCurrentTimeChanged)
        XCTAssertNotNil(createAction(from: .AdVolumeChange(1)) as? VPAIDActions.AdVolumeChange)
        XCTAssertNotNil(createAction(from: .AdWindowOpen(url)) as? VPAIDActions.AdWindowOpen)
        XCTAssertNotNil(createAction(from: .AdUniqueEventAbuse(name: "", value: "")) as? VPAIDActions.AdUniqueEventAbuse)
        XCTAssertNotNil(createAction(from: .AdJSEvaluationFailed(NSError(domain: "", code: 901))) as? VPAIDActions.AdJavaScriptEvaluationError)
    }
}
