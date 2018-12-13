//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlayAdActionCreatorTestCase: XCTestCase {
    func testWithMp4MediaFile() {
        let mediaFiles = [Ad.VASTModel.MediaFile.mp4(with: testUrl)]
        let model = Ad.VASTModel.model(with: mediaFiles)
        guard let action = PlayerCore.playAd(model: model,
                                             id: UUID(),
                                             isOpenMeasurementEnabled: true) as? ShowAd else { return XCTFail() }
        guard case .mp4(_) = action.creative else { return XCTFail() }
    }
    
    func testWithVPAIDMediaFile() {
        let mediaFiles = [Ad.VASTModel.MediaFile.vpaid(with: testUrl)]
        let model = Ad.VASTModel.model(with: mediaFiles)
        guard let action = PlayerCore.playAd(model: model,
                                             id: UUID(),
                                             isOpenMeasurementEnabled: true) as? ShowAd else { return XCTFail() }
        guard case .vpaid(_) = action.creative else { return XCTFail() }
    }
    
    func testWithMp4AndVPAIDMediafile() {
        let mediaFiles = [Ad.VASTModel.MediaFile.mp4(with: testUrl),
                          Ad.VASTModel.MediaFile.vpaid(with: testUrl)]
        let model = Ad.VASTModel.model(with: mediaFiles)
        do {
            guard let action = PlayerCore.playAd(model: model,
                                                 id: UUID(),
                                                 isOpenMeasurementEnabled: true) as? ShowAd else { return XCTFail() }
            guard case .mp4(_) = action.creative else { return XCTFail() }
        }
        do {
            guard let action = PlayerCore.playAd(model: model,
                                                 id: UUID(),
                                                 isOpenMeasurementEnabled: true) as? ShowAd else { return XCTFail() }
            guard case .mp4(_) = action.creative else { return XCTFail() }
        }
    }
}

extension Ad.VASTModel.MediaFile {
    static func mp4(with url: URL) -> Ad.VASTModel.MediaFile {
        return Ad.VASTModel.MediaFile(url: url,
                         type: .mp4,
                         width: 300,
                         height: 400,
                         scalable: false,
                         maintainAspectRatio: true)
    }
    static func vpaid(with url: URL) -> Ad.VASTModel.MediaFile {
        return Ad.VASTModel.MediaFile(url: url,
                         type: .vpaid,
                         width: 300,
                         height: 400,
                         scalable: false,
                         maintainAspectRatio: true)
    }
}

extension Ad.VASTModel {
    static func model(with mediaFiles: [Ad.VASTModel.MediaFile]) -> Ad.VASTModel  {
        return Ad.VASTModel(
            adVerifications: [],
            mediaFiles: mediaFiles,
            clickthrough: nil,
            adParameters: nil,
            pixels: AdPixels(impression: [],
                             error: [],
                             clickTracking: [],
                             creativeView: [],
                             start: [],
                             firstQuartile: [],
                             midpoint: [],
                             thirdQuartile: [],
                             complete: [],
                             pause: [],
                             resume: []),
            id: nil)
    }
}
