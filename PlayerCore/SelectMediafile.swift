//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

public func selectMediafile(of type: MediaFileType) -> Action {
    return SelectMediaFileByType(type: type)
}
