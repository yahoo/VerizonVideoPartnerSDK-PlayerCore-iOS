//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PictureInPictureActionCreatorTestCase: XCTestCase {
    func testToggle() {
        XCTAssertNotNil(pictureInPictureToggle() as? PictureInPictureToggle)
    }
    
    func testStatusUpdate() {
        XCTAssertNotNil(pictureInPictureStatusUpdate(isPossible: true) as? PictureInPictureStatusUpdate)
    }
}
