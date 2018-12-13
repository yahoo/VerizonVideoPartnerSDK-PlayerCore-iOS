//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PictureInPictureComponentTestCase: XCTestCase {
    let initial = PictureInPicture.impossible
    func testReduceOnUpdatePipStatus() {
        var sut = reduce(state: initial, action: PictureInPictureStatusUpdate(isPossible: true))
        XCTAssertEqual(sut, .inactive)
        
        sut = reduce(state: sut, action: PictureInPictureStatusUpdate(isPossible: false))
        XCTAssertEqual(sut, .impossible)
        
        sut = reduce(state: sut, action: PictureInPictureToggle())
        XCTAssertEqual(sut, .impossible)
    }
    
    func testReduceOnTogglePip() {
        var sut = reduce(state: initial, action: PictureInPictureToggle())
        XCTAssertEqual(sut, .impossible)
        
        sut = reduce(state: sut, action: PictureInPictureStatusUpdate(isPossible: true))
        XCTAssertEqual(sut, .inactive)
        
        sut = reduce(state: sut, action: PictureInPictureToggle())
        XCTAssertEqual(sut, .active)
        
        sut = reduce(state: sut, action: PictureInPictureToggle())
        XCTAssertEqual(sut, .inactive)
    }
    
    func testReduceOnOtherAction() {
        let sut = reduce(state: initial, action: Play(time: Date()))
        XCTAssertEqual(sut, .impossible)
    }
    
    func testReduceOnPipStatusUpdateWhilePipIsActive() {
        var sut = reduce(state: initial, action: PictureInPictureStatusUpdate(isPossible: true))
        XCTAssertEqual(sut, .inactive)

        sut = reduce(state: sut, action: PictureInPictureToggle())
        XCTAssertEqual(sut, .active)
        
        sut = reduce(state: sut, action: PictureInPictureStatusUpdate(isPossible: true))
        XCTAssertEqual(sut, .active)
    }
}
