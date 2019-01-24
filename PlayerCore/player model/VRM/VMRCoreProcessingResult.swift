//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation

extension VRMCore {
    public struct Result: Hashable {
        public let item: VRMCore.Item
        public let inlineVAST: Ad.VASTModel
    }
}
