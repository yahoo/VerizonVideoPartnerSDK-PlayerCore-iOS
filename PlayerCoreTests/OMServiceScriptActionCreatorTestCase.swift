//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class OMServiceScriptActionCreatorTestCase: XCTestCase {
    
    func testScriptLoadingFailed() {
        struct Failed: Error {}
        XCTAssertNotNil(PlayerCore.failedOMScriptLoading(with: Failed()) as? OpenMeasurementScriptLoadingFailed)
    }
    func testScriptRecieved() {
        XCTAssertNotNil(PlayerCore.recievedOMScript() as? OpenMeasurementScriptRecieved)
    }
}
