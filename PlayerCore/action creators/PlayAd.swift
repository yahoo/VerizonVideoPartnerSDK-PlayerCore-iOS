//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public func playAd(model: Ad.VASTModel, id: UUID, isOpenMeasurementEnabled: Bool) -> Action {
    let adCreative: AdCreative? = {
        if case .mp4(let mediaFile)? = model.videos.first {
            return AdCreative.mp4(
                .init(
                    url: mediaFile.url,
                    clickthrough: model.clickthrough,
                    pixels: model.pixels,
                    id: model.id,
                    scalable: mediaFile.scalable,
                    maintainAspectRatio: mediaFile.maintainAspectRatio))
        }
        if case .vpaid(let mediaFile)? = model.videos.first {
            return AdCreative.vpaid(
                .init(
                    url: mediaFile.url,
                    adParameters: model.adParameters,
                    clickthrough: model.clickthrough,
                    pixels: model.pixels,
                    id: model.id))
        }
        return nil
    }()
    guard let creative = adCreative else { return SkipAd(id: id) }
    return ShowAd(creative: creative,
                  id: id,
                  adVerifications: model.adVerifications,
                  isOpenMeasurementEnabled: isOpenMeasurementEnabled)
}

