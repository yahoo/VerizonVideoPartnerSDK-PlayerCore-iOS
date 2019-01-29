//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public func playAd(model: Ad.VASTModel, id: UUID, isOpenMeasurementEnabled: Bool) -> Action {
    let adCreative: AdCreative? = {
        if let mediaFile = model.mp4MediaFiles.first {
            return AdCreative.mp4(
                [.init(
                    url: mediaFile.url,
                    clickthrough: model.clickthrough,
                    pixels: model.pixels,
                    id: model.id,
                    width: mediaFile.width,
                    height: mediaFile.height,
                    scalable: mediaFile.scalable,
                    maintainAspectRatio: mediaFile.maintainAspectRatio)])
        }
        if let mediaFile = model.vpaidMediaFiles.first {
            return AdCreative.vpaid(
                [.init(
                    url: mediaFile.url,
                    adParameters: model.adParameters,
                    clickthrough: model.clickthrough,
                    pixels: model.pixels,
                    id: model.id)])
        }
        return nil
    }()
    guard let creative = adCreative else { return SkipAd(id: id) }
    return ShowAd(creative: creative,
                  id: id,
                  adVerifications: model.adVerifications,
                  isOpenMeasurementEnabled: isOpenMeasurementEnabled)
}

