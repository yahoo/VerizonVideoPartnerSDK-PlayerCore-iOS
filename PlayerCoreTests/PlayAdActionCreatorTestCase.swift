//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class PlayAdActionCreatorTestCase: XCTestCase {
    func testWithMp4MediaFile() {
        let mediaFiles = [Ad.VASTModel.MP4MediaFile.video(with: testUrl)]
        let model = Ad.VASTModel.model(withMp4: mediaFiles, andVpaid: [])
        guard let action = PlayerCore.playAd(model: model,
                                             id: UUID()) as? ShowAd else { return XCTFail() }
        guard case .mp4(_) = action.creative else { return XCTFail() }
    }
    
    func testWithVPAIDMediaFile() {
        let mediaFiles = [Ad.VASTModel.VPAIDMediaFile.video(with: testUrl)]
        let model = Ad.VASTModel.model(withMp4: [], andVpaid: mediaFiles)
        guard let action = PlayerCore.playAd(model: model,
                                             id: UUID()) as? ShowAd else { return XCTFail() }
        guard case .vpaid(_) = action.creative else { return XCTFail() }
    }
    
    func testWithMp4AndVPAIDMediafile() {
        let mp4MediaFiles = [Ad.VASTModel.MP4MediaFile.video(with: testUrl)]
        let vpaidMediaFiles = [Ad.VASTModel.VPAIDMediaFile.video(with: testUrl)]
        let model = Ad.VASTModel.model(withMp4: mp4MediaFiles, andVpaid: vpaidMediaFiles)
        do {
            guard let action = PlayerCore.playAd(model: model,
                                                 id: UUID()) as? ShowAd else { return XCTFail() }
            guard case .mp4(_) = action.creative else { return XCTFail() }
        }
        do {
            guard let action = PlayerCore.playAd(model: model,
                                                 id: UUID()) as? ShowAd else { return XCTFail() }
            guard case .mp4(_) = action.creative else { return XCTFail() }
        }
    }
}

extension Ad.VASTModel.MP4MediaFile {
    static func video(with url: URL) -> Ad.VASTModel.MP4MediaFile {
        return Ad.VASTModel.MP4MediaFile(url: url,
                                         width: 300,
                                         height: 400,
                                         scalable: false,
                                         maintainAspectRatio: true)
    }
}
extension Ad.VASTModel.VPAIDMediaFile {
    static func video(with url: URL) -> Ad.VASTModel.VPAIDMediaFile {
        return Ad.VASTModel.VPAIDMediaFile(url: url,
                                           scalable: false,
                                           maintainAspectRatio: true)
    }
}

extension Ad.VASTModel {
    static func model(withMp4 mp4: [Ad.VASTModel.MP4MediaFile],
                      andVpaid vpaid: [Ad.VASTModel.VPAIDMediaFile]) -> Ad.VASTModel  {
        return Ad.VASTModel(
            adVerifications: [],
            mp4MediaFiles: mp4,
            vpaidMediaFiles: vpaid,
            skipOffset: .none,
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
