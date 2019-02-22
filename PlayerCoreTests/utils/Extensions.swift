//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation
import PlayerCore

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
            adProgress: [],
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
