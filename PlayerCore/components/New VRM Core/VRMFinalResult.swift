//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public struct VRMFinalResult {
    static let initial = VRMFinalResult(result: nil)
    
    public let result: VRMCore.Result?
}

func reduce(state: VRMFinalResult, action: Action) -> VRMFinalResult {
    switch action {
    case let finalResult as VRMCore.SelectFinalResult:
        return VRMFinalResult(result: VRMCore.Result(item: finalResult.item,
                                                     inlineVAST: finalResult.inlineVAST))
    case is AdPlaybackFailed,
         is AdStartTimeout,
         is AdError,
         is AdNotSupported,
         is VRMCore.AdRequest:
        return VRMFinalResult(result: nil)
    default: return state
    }
}
