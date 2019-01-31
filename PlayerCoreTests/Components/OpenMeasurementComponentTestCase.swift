//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class OpenMeasurementComponentTestCase: XCTestCase {
    let adVerifications = [Ad.VASTModel.AdVerification(vendorKey: "TestApp",
                                                     javaScriptResource: testUrl,
                                                     verificationParameters: testUrl,
                                                     verificationNotExecuted: testUrl)]
    let initial = OpenMeasurement.inactive
    struct Failed: Swift.Error {}
    var sut: OpenMeasurement!
    
    override func setUp() {
        sut = initial
    }
    func testDefaultBehavior() {
        sut = reduce(state: sut, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]),
                                                id: UUID(),
                                                adVerifications: adVerifications,
                                                isOpenMeasurementEnabled: true))
        XCTAssertEqual(sut, .loading(adVerifications))
        
        sut = reduce(state: sut, action: OpenMeasurementActivated(adEvents: .empty, videoEvents: .empty))
        XCTAssertTrue(sut.isActive)
        
        sut = reduce(state: sut, action: ShowContent())
        XCTAssertTrue(sut.isFinished)
        sut = reduce(state: sut, action: openMeasurementDeactivated())
        XCTAssertEqual(sut, .inactive)

    }
    func testAdVerificationNotParsed() {
        sut = reduce(state: sut, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]),
                                                id: UUID(),
                                                adVerifications: [],
                                                isOpenMeasurementEnabled: true))
        XCTAssertEqual(sut, .inactive)
    }
    func testFailedMeasurement() {
        sut = reduce(state: sut, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]),
                                                id: UUID(),
                                                adVerifications: adVerifications,
                                                isOpenMeasurementEnabled: true))
        sut = reduce(state: sut, action: OpenMeasurementActivated(adEvents: .empty, videoEvents: .empty))
        XCTAssertTrue(sut.isActive)
        
        sut = reduce(state: sut, action: OpenMeasurementConfigurationFailed(error: Failed()))
        XCTAssertTrue(sut.isActive)
        
        sut = reduce(state: sut, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]),
                                                id: UUID(),
                                                adVerifications: adVerifications,
                                                isOpenMeasurementEnabled: true))
        sut = reduce(state: sut, action: OpenMeasurementConfigurationFailed(error: Failed()))
        XCTAssertTrue(sut.isFailed)
    }
    func testReduceWithDisabledOM() {
        sut = reduce(state: sut, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]),
                                                id: UUID(),
                                                adVerifications: adVerifications,
                                                isOpenMeasurementEnabled: false))
        XCTAssertEqual(sut, .disabled)
        
        sut = reduce(state: sut, action: ShowContent())
        XCTAssertEqual(sut, .disabled)
    }
}
