//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation

public enum MediaFileType {
    case mp4([Ad.VASTModel.MP4MediaFile])
    case vpaid([Ad.VASTModel.VPAIDMediaFile])
    case none
}

public struct MediaFile {
    let type: MediaFileType
}

func reduce(state: MediaFile, action: Action) -> MediaFile {
    switch action {
    case let action as SelectMediaFileByType:
        return MediaFile(type: action.type)
    case is AdRequest:
        return MediaFile(type: .none)
    default: return state
    }
}
