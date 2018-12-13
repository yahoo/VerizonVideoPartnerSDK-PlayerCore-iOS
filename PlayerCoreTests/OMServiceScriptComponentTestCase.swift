//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class OMServiceScriptComponentTestCase: XCTestCase {
    let initial = OpenMeasurementServiceScript.none
    var sut: OpenMeasurementServiceScript!
    
    override func setUp() {
        sut = initial
    }

    func testSuccessfulScriptLoading() {
        XCTAssertEqual(sut, OpenMeasurementServiceScript.none)
        sut = reduce(state: sut, action: OpenMeasurementScriptRecieved())
        XCTAssertEqual(sut, OpenMeasurementServiceScript.recieved)
    }
    func testFailedScriptLoading() {
        struct Failed: Error { }
        sut = reduce(state: sut, action: OpenMeasurementScriptLoadingFailed(error: Failed()))
        XCTAssertTrue(sut.isFailed)
    }
}
