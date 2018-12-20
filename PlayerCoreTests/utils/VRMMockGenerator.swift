//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation
@testable import PlayerCore

enum VRMMockGenerator {
    static func createMetaInfo() -> VRMCore.Item.MetaInfo {
        return VRMCore.Item.MetaInfo(engineType: "engineType",
                                     ruleId: "ruleId",
                                     ruleCompanyId: "ruleCompanyId",
                                     vendor: "vendor",
                                     name: "name",
                                     cpm: "cpm")
    }
    
    static func createVASTItem() -> VRMCore.Item {
        return .vast("VAST String", createMetaInfo())
    }
    
    static func createUrlItem() -> VRMCore.Item {
        return .url(URL(string: "http://test.com")!, createMetaInfo())
    }
}
