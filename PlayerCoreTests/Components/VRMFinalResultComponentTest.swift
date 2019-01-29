//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore


class VRMFinalResultComponentTest: XCTestCase {

    func testReducer() {
        struct CustomError: CustomNSError {}
        let vastItem = VRMMockGenerator.createVASTItem()
        let vastModel = Ad.VASTModel(adVerifications: [],
                                     mp4MediaFiles: [],
                                     vpaidMediaFiles: [],
                                     clickthrough: nil,
                                     adParameters: nil,
                                     pixels: AdPixels(),
                                     id: nil)
        let sut = reduce(state: VRMFinalResult.initial, action: VRMCore.selectFinalResult(item: vastItem,
                                                                                          inlineVAST: vastModel))
        XCTAssertEqual(sut.result?.inlineVAST, vastModel)
        
        var emptySut = reduce(state: sut, action: AdError(error: CustomError()))
        XCTAssertNil(emptySut.result)
        
        emptySut = reduce(state: sut, action: AdPlaybackFailed(error: CustomError() as NSError))
        XCTAssertNil(emptySut.result)
        
        emptySut = reduce(state: sut, action: AdStartTimeout())
        XCTAssertNil(emptySut.result)
        
        emptySut = reduce(state: sut, action: AdNotSupported())
        XCTAssertNil(emptySut.result)
        
        emptySut = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertNil(emptySut.result)
    }

}
