//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class OpenMeasurementActionCreatorTestCase: XCTestCase {
    
    func testFailedOMConfigurationAction() {
        struct Failed: Error { }
        XCTAssertNotNil(PlayerCore.failedOMConfiguration(with: Failed()) as? OpenMeasurementConfigurationFailed)
    }
    func testUpdateActivatedStateAction() {
        XCTAssertNotNil(PlayerCore.openMeasurementActivated(
            adEvents: OpenMeasurement.AdEvents.empty,
            videoEvents: OpenMeasurement.VideoEvents.empty) as? OpenMeasurementActivated)
    }
    func testUpdateDeactivatedStateAction() {
        XCTAssertNotNil(PlayerCore.openMeasurementDeactivated())
    }
}
