//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation

public struct SelectedAdCreative {
    public let creative: AdCreative
}

func reduce(state: SelectedAdCreative, action: Action) -> SelectedAdCreative {
    switch action {
    case let action as VRMCore.SelectFinalResult:
        let mp4AdCreatives: [AdCreative.MP4] = action.inlineVAST.mp4MediaFiles.compactMap {
            return .init(
                url: $0.url,
                clickthrough: action.inlineVAST.clickthrough,
                pixels: action.inlineVAST.pixels,
                id: action.inlineVAST.id,
                width: $0.width,
                height: $0.height,
                scalable: $0.scalable,
                maintainAspectRatio: $0.maintainAspectRatio)
        }
        guard mp4AdCreatives.isEmpty else {
            return SelectedAdCreative(creative: .mp4(mp4AdCreatives))
        }
        let vpaidAdCreatives: [AdCreative.VPAID] = action.inlineVAST.vpaidMediaFiles.compactMap {
            return .init(
                url: $0.url,
                adParameters: action.inlineVAST.adParameters,
                clickthrough: action.inlineVAST.clickthrough,
                pixels: action.inlineVAST.pixels,
                id: action.inlineVAST.id)
        }
        guard vpaidAdCreatives.isEmpty else {
            return SelectedAdCreative(creative: .vpaid(vpaidAdCreatives))
        }
        return SelectedAdCreative(creative: .none)
    case is VRMCore.AdRequest:
        return SelectedAdCreative(creative: .none)
    default: return state
    }
}
