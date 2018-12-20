//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

extension VRMCore {
    
    enum StartItem: Action {
        case parsing( originalItem: Item, vastXML: String, startDate: Date)
        case fetching( originalItem: Item, url: URL, startDate: Date)
    }
}
