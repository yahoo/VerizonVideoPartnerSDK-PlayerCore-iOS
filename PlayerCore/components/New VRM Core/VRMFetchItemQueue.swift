//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public struct VRMFetchItemQueue {
    
    static let initial = VRMFetchItemQueue(candidates: [])
    
    public struct FetchCandidate: Hashable {
        public let parentItem: VRMCore.Item
        public let id: VRMCore.ID<FetchCandidate>
        public let url: URL
    }
    
    public let candidates: Set<FetchCandidate>
}

func reduce(state: VRMFetchItemQueue, action: Action) -> VRMFetchItemQueue {
    switch action {
    case let fetchAction as VRMCore.StartItemFetch:
        let candidate = VRMFetchItemQueue.FetchCandidate(parentItem: fetchAction.originalItem,
                                                         id: VRMCore.ID(),
                                                         url: fetchAction.url)
        var newSet = Set<VRMFetchItemQueue.FetchCandidate>(state.candidates)
        newSet.insert(candidate)
        return VRMFetchItemQueue(candidates: newSet)
    default:
        return state
    }
}
