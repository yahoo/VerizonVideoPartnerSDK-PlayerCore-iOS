//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation

public extension VRMCore {
    public static func startItemParsing(originalItem: Item, vastXML: String, startDate: Date = Date()) -> Action {
        return StartItemParsing(originalItem: originalItem, vastXML: vastXML, startDate: startDate)
    }
    
    public static func completeItemParsing(originalItem: Item, vastModel: VRMCore.VASTModel, startDate: Date = Date()) -> Action {
        return CompleteItemParsing(originalItem: originalItem, vastModel: vastModel, date: startDate )
    }
    
    public static func failedItemParse(originalItem: Item) -> Action {
        return ParsingError(originalItem: originalItem)
    }
    
    public static func startItemFetch(originalItem: Item, url: URL,  startDate: Date = Date()) -> Action {
        return StartItemFetch(originalItem: originalItem, url: url, startDate: startDate)
    }
    
    public static func failedItemFetch(originalItem: Item) -> Action {
        return FetchingError(originalItem: originalItem)
    }
    
    public static func unwrapItem(item: Item, url: URL) -> Action {
        return UnwrapItem(url: url, item: item)
    }
    
    public static func tooManyIndirections(item: Item) -> Action {
        return TooManyIndirections(item: item)
    }
    
    public static func timeoutError(item: Item) -> Action {
        return TimeoutError(item: item)
    }
}
