//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class UpdateCameraAnglesActionCreatorTestCase: XCTestCase {
    func testOnAction() {
        XCTAssertNotNil(PlayerCore.updateCameraAngles(horizontal: 0, vertical: 0) as? UpdateCameraAngles)
    }
    func testVerticalAngle() {
        let expected = UpdateCameraAngles(horizontal: 1.5, vertical: 1.5)
        guard let result = PlayerCore.updateCameraAngles(horizontal: 1.5, vertical: 1.5) as? UpdateCameraAngles else { return XCTFail("Failed to get action")}
        XCTAssertEqual(result, expected)
    }
    func testHigherVerticalAngle() {
        let expected = UpdateCameraAngles(horizontal: -1, vertical: 1.57079637)
        guard let result = PlayerCore.updateCameraAngles(horizontal: -1, vertical: 3.14) as? UpdateCameraAngles else { return XCTFail("Failed to get action")}
        XCTAssertEqual(result, expected)
    }
}
