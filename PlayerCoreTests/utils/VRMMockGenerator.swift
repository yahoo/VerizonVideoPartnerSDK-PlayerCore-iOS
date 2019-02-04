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
    
    static func createVASTItem(id: VRMCore.ID<VRMCore.Item> = VRMCore.ID()) -> VRMCore.Item {
        return VRMCore.Item(id: id,
                            source: .vast("VAST String"),
                            metaInfo: createMetaInfo())
    }
    
    static func createUrlItem(id: VRMCore.ID<VRMCore.Item> = VRMCore.ID()) -> VRMCore.Item {
        return VRMCore.Item(id: id,
                            source: .url(URL(string: "http://test.com")!),
                            metaInfo: createMetaInfo())
    }
    
    static func createVASTAdModel() -> Ad.VASTModel {
        return Ad.VASTModel(adVerifications: [],
                            mp4MediaFiles: [],
                            vpaidMediaFiles: [],
                            clickthrough: nil,
                            adParameters: nil,
                            pixels: .init(),
                            id: nil)
    }
}
