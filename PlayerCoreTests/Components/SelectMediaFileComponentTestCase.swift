//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
import CoreMedia
@testable import PlayerCore

class SelectMediaFileComponentTestCase: XCTestCase {
    
    let initial = MediaFile(type: .none)
    
    func testReduceOnAttachToViewport() {
        let sut = reduce(state: initial, action: SelectMediaFileByType(type: .mp4(Ad.VASTModel.MediaFile.mp4(with: URL(fileURLWithPath: "")))))
        guard case .mp4 = sut.type else { XCTFail("Not equal")}
    }
}
