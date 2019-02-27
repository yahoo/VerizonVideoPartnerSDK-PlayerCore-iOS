//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class MP4AdBufferingTimeComponentTest: XCTestCase {
    
    let url = URL(string: "http://test.com")!
    
    func testStartBuffering() {
        let initial = MP4AdBufferingTime.initial
        let sut = reduce(state: initial, action: AdPlaybackBufferingActive())
        guard case .inProgress = sut.status else { XCTFail("on play mp4 Ad sut should be .inProgress, actual \(sut)"); return }
    }
    
    func testFinishBuffering() {
        let initialDate = Date()
        let initial = MP4AdBufferingTime(status: .inProgress(startAt: initialDate))
        
        let sut = reduce(state: initial, action: AdPlaybackBufferingInactive())
        
        guard case let .finished(startAt, _) = sut.status else {
            XCTFail("on AdPlaybackBufferingInactive sut should be .finished, actual \(sut)")
            return
        }
        XCTAssertEqual(initialDate, startAt)
    }
    
    func testResetState() {
        let initialDate = Date()
        let initial = MP4AdBufferingTime(status: .inProgress(startAt: initialDate))
        
        let actions: [PlayerCore.Action] = [AdPlaybackFailed(error: NSError(domain: "", code: 1, userInfo: nil)),
                                            VRMCore.AdRequest(url: url, id: UUID(), type: .preroll),
                                            AdStartTimeout()]
        actions.forEach { action in
            let sut = reduce(state: initial, action: action)
            guard case .empty = sut.status else { XCTFail("on \(action) sut should be .empty, actual \(sut)"); return }
        }
    }
}
