//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdCreativeComponentTestCase: XCTestCase {
    
    let initial = AdCreative.none
    
    func testReduceOnSelectFinalResultWithMP4() {
        let vastModel = Ad.VASTModel.model(withMp4: [Ad.VASTModel.MP4MediaFile(url: testUrl,
                                                                                 width: 320,
                                                                                 height: 240,
                                                                                 scalable: false,
                                                                                 maintainAspectRatio: true)],
                                           andVpaid: [])
        let sut = reduce(state: initial, action: VRMCore.SelectFinalResult(
            item: VRMCore.Item.init(
                source: .vast(""),
                metaInfo: .init(engineType: "", ruleId: "", ruleCompanyId: "", vendor: "", name: "", cpm: "")),
            inlineVAST: vastModel))
        
        guard case .mp4 = sut else { return XCTFail("Not Equal") }
    }
    func testReduceOnSelectFinalResultWithVpaid() {
        let vastModel = Ad.VASTModel.model(withMp4: [],
                                           andVpaid: [Ad.VASTModel.VPAIDMediaFile(url: testUrl,
                                                                                scalable: false,
                                                                                maintainAspectRatio: true)])
        let sut = reduce(state: initial, action: VRMCore.SelectFinalResult(
            item: VRMCore.Item.init(
                source: .vast(""),
                metaInfo: .init(engineType: "", ruleId: "", ruleCompanyId: "", vendor: "", name: "", cpm: "")),
            inlineVAST: vastModel))
        
        guard case .vpaid = sut else { return XCTFail("Not equal")}
    }
    func testReduceOnSelectFinalResultWithMp4AndVpaid() {
        let vastModel = Ad.VASTModel.model(withMp4: [Ad.VASTModel.MP4MediaFile(url: testUrl,
                                                                               width: 320,
                                                                               height: 240,
                                                                               scalable: false,
                                                                               maintainAspectRatio: true)],
                                           andVpaid: [Ad.VASTModel.VPAIDMediaFile(url: testUrl,
                                                                                  scalable: false,
                                                                                  maintainAspectRatio: true)])
        let sut = reduce(state: initial, action: VRMCore.SelectFinalResult(
            item: VRMCore.Item.init(
                source: .vast(""),
                metaInfo: .init(engineType: "", ruleId: "", ruleCompanyId: "", vendor: "", name: "", cpm: "")),
            inlineVAST: vastModel))
        
        guard case .mp4 = sut else { return XCTFail("Not equal")}
    }
    func testReduceOnAdRequest() {
        let vastModel = Ad.VASTModel.model(withMp4: [Ad.VASTModel.MP4MediaFile(url: testUrl,
                                                                               width: 320,
                                                                               height: 240,
                                                                               scalable: false,
                                                                               maintainAspectRatio: true)],
                                           andVpaid: [Ad.VASTModel.VPAIDMediaFile(url: testUrl,
                                                                                  scalable: false,
                                                                                  maintainAspectRatio: true)])
        var sut = reduce(state: initial, action: VRMCore.SelectFinalResult(
            item: VRMCore.Item.init(
                source: .vast(""),
                metaInfo: .init(engineType: "", ruleId: "", ruleCompanyId: "", vendor: "", name: "", cpm: "")),
            inlineVAST: vastModel))
        sut = reduce(state: sut, action: VRMCore.AdRequest(url: testUrl, id: UUID(), type: .preroll))
        
        guard case .none = sut else { return XCTFail("Not equal")}
    }
}
