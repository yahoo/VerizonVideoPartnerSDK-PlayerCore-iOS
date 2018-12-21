//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation

public extension VRMCore {
    public static func startItemParsing(originalItem: Item, vastXML: String, startDate: Date = Date()) -> Action {
        return StartItemParsing(originalItem: originalItem, vastXML: vastXML, startDate: startDate)
    }
    
    public static func startItemFetch(originalItem: Item, url: URL,  startDate: Date = Date()) -> Action {
        return StartItemFetch(originalItem: originalItem, url: url, startDate: startDate)
    }
    
    public static func failedItemFetch(originalItem: Item, fetchCandidate: VRMFetchItemQueue.FetchCandidate) -> Action {
        return FetchingError(originalItem: originalItem, fetchCandidate: fetchCandidate)
    }
}
