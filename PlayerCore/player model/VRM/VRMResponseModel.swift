//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public extension VRMCore {
    
    public struct Group: Equatable {
        public let items: [Item]
        
        public init(items: [Item]) {
            self.items = items
        }
    }
    
    public enum Item: Equatable {
        public struct MetaInfo: Equatable {
            public let id: UUID
            public let engineType: String?
            public let ruleId: String?
            public let ruleCompanyId: String?
            public let vendor: String
            public let name: String?
            
            public init(engineType: String?,
                        ruleId: String?,
                        ruleCompanyId: String?,
                        vendor: String,
                        name: String?) {
                self.id = UUID()
                self.engineType = engineType
                self.ruleId = ruleId
                self.ruleCompanyId = ruleCompanyId
                self.vendor = vendor
                self.name = name
            }
        }
        
        case vast(String, MetaInfo)
        case url(URL, MetaInfo)
    }
}
