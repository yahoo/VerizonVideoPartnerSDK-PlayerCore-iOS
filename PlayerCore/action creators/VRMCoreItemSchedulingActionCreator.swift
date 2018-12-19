//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation

public extension VRMCore {
    public static func startItemParsing(originalItem: Item, vastXML: String, startDate: Date = Date()) -> Action {
        guard case .vast = originalItem else { fatalError("can't start parsing of url item") }
        
        return StartItem.parsing(originalItem: originalItem, vastXML: vastXML, startDate: startDate)
    }
    
    public static func startItemFetch(originalItem: Item, url: URL,  startDate: Date = Date()) -> Action {
        guard case .url = originalItem else { fatalError("can't start fetching of vast string item") }
        
        return StartItem.fetching(originalItem: originalItem, url: url, startDate: startDate)
    }
}
