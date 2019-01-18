//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

extension VRMCore {
    public static func softTimeoutReached() -> Action {
        return SoftTimeout()
    }
    
    public static func hardTimeoutReached() -> Action {
        return HardTimeout()
    }
    
    public static func maxSearchTimeoutReached() -> Action {
        return MaxSearchTimeout()
    }
}
