//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlayAdActionCreatorTestCase: XCTestCase {
    func testWithMp4MediaFile() {
        let mediaFiles = [Ad.VASTModel.VideoType.mp4Ad(with: testUrl)]
        let model = Ad.VASTModel.model(with: mediaFiles)
        guard let action = PlayerCore.playAd(model: model,
                                             id: UUID(),
                                             isOpenMeasurementEnabled: true) as? ShowAd else { return XCTFail() }
        guard case .mp4(_) = action.creative else { return XCTFail() }
    }
    
    func testWithVPAIDMediaFile() {
        let mediaFiles = [Ad.VASTModel.VideoType.vpaidAd(with: testUrl)]
        let model = Ad.VASTModel.model(with: mediaFiles)
        guard let action = PlayerCore.playAd(model: model,
                                             id: UUID(),
                                             isOpenMeasurementEnabled: true) as? ShowAd else { return XCTFail() }
        guard case .vpaid(_) = action.creative else { return XCTFail() }
    }
    
    func testWithMp4AndVPAIDMediafile() {
        let mediaFiles = [Ad.VASTModel.VideoType.mp4Ad(with: testUrl),
                          Ad.VASTModel.VideoType.vpaidAd(with: testUrl)]
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

extension Ad.VASTModel.VideoType {
    static func mp4Ad(with url: URL) -> Ad.VASTModel.VideoType {
        return .mp4(Ad.VASTModel.MediaFile(url: url,
                         width: 300,
                         height: 400,
                         scalable: false,
                         maintainAspectRatio: true))
    }
    static func vpaidAd(with url: URL) -> Ad.VASTModel.VideoType {
        return .vpaid(Ad.VASTModel.MediaFile(url: url,
                         width: 300,
                         height: 400,
                         scalable: false,
                         maintainAspectRatio: true))
    }
}

extension Ad.VASTModel {
    static func model(with videos: [Ad.VASTModel.VideoType]) -> Ad.VASTModel  {
        return Ad.VASTModel(
            adVerifications: [],
            videos: videos,
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
