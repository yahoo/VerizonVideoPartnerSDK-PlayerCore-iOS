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
                                     skipOffset: .none,
                                     clickthrough: nil,
                                     adParameters: nil,
                                     adProgress: [],
                                     pixels: AdPixels(),
                                     id: nil)
        
        let result = VRMCore.Result(item: vastItem, inlineVAST: vastModel)
        let sut = reduce(state: VRMFinalResult.initial,
                         action: VRMCore.selectFinalResult(item: vastItem,
                                                           inlineVAST: vastModel))
        XCTAssertEqual(sut.successResult?.inlineVAST, vastModel)
        
        var emptySut = reduce(state: sut, action: AdError(error: CustomError()))
        XCTAssertNil(emptySut.successResult)
        XCTAssertNotNil(emptySut.failedResult)
        XCTAssertEqual(emptySut, .failed(result: result))
        
        emptySut = reduce(state: sut, action: AdPlaybackFailed(error: CustomError() as NSError))
        XCTAssertNil(emptySut.successResult)
        XCTAssertNotNil(emptySut.failedResult)
        XCTAssertEqual(emptySut, .failed(result: result))
        
        emptySut = reduce(state: sut, action: AdStartTimeout())
        XCTAssertNil(emptySut.successResult)
        XCTAssertNotNil(emptySut.failedResult)
        XCTAssertEqual(emptySut, .failed(result: result))
        
        emptySut = reduce(state: sut, action: AdNotSupported())
        XCTAssertNil(emptySut.successResult)
        XCTAssertNotNil(emptySut.failedResult)
        XCTAssertEqual(emptySut, .failed(result: result))
        
        emptySut = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertNil(emptySut.successResult)
        XCTAssertNil(emptySut.failedResult)
        XCTAssertEqual(emptySut, .empty)
    }

}
