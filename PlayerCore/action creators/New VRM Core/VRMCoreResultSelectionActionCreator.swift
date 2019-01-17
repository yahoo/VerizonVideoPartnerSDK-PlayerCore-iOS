//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public extension VRMCore {
    public static func selectInlineVAST(originalItem: Item, inlineVAST: Ad.VASTModel) -> Action {
        return SelectInlineItem(originalItem: originalItem, inlineVAST: inlineVAST)
    }
}
