//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public struct AdFinishTracker {
    public let isForceFinished: Bool
    public let isSuccessfullyCompleted: Bool
}

func reduce(state: AdFinishTracker, action: Action) -> AdFinishTracker {
    switch action {
    
    case is ShowMP4Ad, is ShowVPAIDAd, is ShowAd:
        return AdFinishTracker(isForceFinished: false, isSuccessfullyCompleted: false)
        
    case is SkipAd, is VRMCore.VRMResponseFetchFailed,
         is AdSkipped, is AdStopped,
         is AdStartTimeout, is AdMaxShowTimeout, is VRMCore.NoGroupsToProcess, is VRMCore.MaxSearchTimeout:
        return AdFinishTracker(isForceFinished: true, isSuccessfullyCompleted: false)
    case is ShowContent:
        return AdFinishTracker(isForceFinished: false, isSuccessfullyCompleted: true)
        
    default: return state
    }    
}
