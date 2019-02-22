//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class OpenMeasurementComponentTestCase: XCTestCase {
    let adVerifications = [Ad.VASTModel.AdVerification(vendorKey: "TestApp",
                                                     javaScriptResource: testUrl,
                                                     verificationParameters: testUrl,
                                                     verificationNotExecuted: testUrl)]
    var mp4InlineVast: Ad.VASTModel!
    var vpaidInlineVast: Ad.VASTModel!
    var emptyInlineVast: Ad.VASTModel!
    
    let initial = OpenMeasurement.inactive
    struct Failed: Swift.Error {}
    var sut: OpenMeasurement!
    
    override func setUp() {
        sut = initial
        mp4InlineVast = VRMMockGenerator.createVASTAdModel(adVerifications: adVerifications,
                                                           mp4MediaFiles: [.init(url: testUrl,
                                                                                 width: 2,
                                                                                 height: 2,
                                                                                 scalable: false,
                                                                                 maintainAspectRatio: false)])
        vpaidInlineVast = VRMMockGenerator.createVASTAdModel(adVerifications: adVerifications,
                                                             vpaidMediaFiles: [.init(url: testUrl,
                                                                                     scalable: false,
                                                                                     maintainAspectRatio: false)])
        emptyInlineVast = VRMMockGenerator.createVASTAdModel()
    }
    func testDefaultBehavior() {
        sut = reduce(state: sut, action: VRMCore.SelectFinalResult(item: VRMMockGenerator.createUrlItem(),
                                                                   inlineVAST: mp4InlineVast))
        XCTAssertEqual(sut, .loading(adVerifications))
        
        sut = reduce(state: sut, action: OpenMeasurementActivated(adEvents: .empty, videoEvents: .empty))
        XCTAssertTrue(sut.isActive)
        
        sut = reduce(state: sut, action: ShowContent())
        XCTAssertTrue(sut.isFinished)
        sut = reduce(state: sut, action: openMeasurementDeactivated())
        XCTAssertEqual(sut, .inactive)

    }
    
    func testProcessVPAIDResult() {
        sut = reduce(state: sut, action: VRMCore.SelectFinalResult(item: VRMMockGenerator.createUrlItem(),
                                                                   inlineVAST: vpaidInlineVast))
        XCTAssertEqual(sut, .inactive)
    }
    
    func testProcessEmptyVAST() {
        sut = reduce(state: sut, action: VRMCore.SelectFinalResult(item: VRMMockGenerator.createUrlItem(),
                                                                   inlineVAST: emptyInlineVast))
        XCTAssertEqual(sut, .inactive)
    }
    
    func testFailedMeasurement() {
        sut = reduce(state: sut, action: VRMCore.SelectFinalResult(item: VRMMockGenerator.createUrlItem(),
                                                                   inlineVAST: mp4InlineVast))
        sut = reduce(state: sut, action: OpenMeasurementActivated(adEvents: .empty, videoEvents: .empty))
        XCTAssertTrue(sut.isActive)
        
        sut = reduce(state: sut, action: OpenMeasurementConfigurationFailed(error: Failed()))
        XCTAssertTrue(sut.isActive)
        
        sut = reduce(state: sut, action: VRMCore.SelectFinalResult(item: VRMMockGenerator.createUrlItem(),
                                                                   inlineVAST: mp4InlineVast))
        sut = reduce(state: sut, action: OpenMeasurementConfigurationFailed(error: Failed()))
        XCTAssertTrue(sut.isFailed)
    }
    func testReduceWithDisabledOM() {
        sut = .disabled
        sut = reduce(state: sut, action: VRMCore.SelectFinalResult(item: VRMMockGenerator.createUrlItem(),
                                                                   inlineVAST: mp4InlineVast))
        XCTAssertEqual(sut, .disabled)
        
        sut = reduce(state: sut, action: ShowContent())
        XCTAssertEqual(sut, .disabled)
    }
}
