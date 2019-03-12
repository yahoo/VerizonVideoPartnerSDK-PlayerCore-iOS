//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdKillTest: XCTestCase {
    
    func testStartTimeout() {
        let sut = reduce(state: AdKill.none, action: MP4AdStartTimeout())
        XCTAssertEqual(sut, .adStartTimeout)
    }
    
    func testMaxShowTime() {
        let sut = reduce(state: AdKill.none, action: AdMaxShowTimeout())
        XCTAssertEqual(sut, .maxShowTime)
    }
    
    func testResetTimeoutState() {
        struct NSErrorMock: CustomNSError {}
        
        let actionsToReset: [Action] = [ShowContent(),
                                        AdPlaybackFailed(error: NSErrorMock() as NSError),
                                        VPAIDActions.AdError(error: NSErrorMock()),
                                        VPAIDActions.AdStopped(),
                                        VPAIDActions.AdSkipped(),
                                        VPAIDActions.AdNotSupported()]
        
        actionsToReset.forEach { action in
            let sut = reduce(state: AdKill.adStartTimeout, action: action)
            XCTAssertEqual(sut, .none, "didn't reduce action \(action)")
        }
    }
}
