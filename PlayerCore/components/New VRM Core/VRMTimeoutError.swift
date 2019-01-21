//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public struct VRMTimeoutError {
    public let erroredItems: Set<VRMCore.Item>
}

func reduce(state: VRMTimeoutError, action: Action) -> VRMTimeoutError {
    switch action {
    case let timeoutError as VRMCore.TimeoutError:
        return VRMTimeoutError(erroredItems: state.erroredItems.union([timeoutError.item]))
    default:
        return state
    }
}
