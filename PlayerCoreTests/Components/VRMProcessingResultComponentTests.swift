//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMProcessingResultComponentTests: XCTestCase {
    
    let inlineVAST = Ad.VASTModel(adVerifications: [],
                                  mp4MediaFiles: [],
                                  vpaidMediaFiles: [],
                                  skipOffset: .none, 
                                  clickthrough: nil,
                                  adParameters: nil,
                                  pixels: AdPixels(),
                                  id: nil)
    
    func testReducer() {
        let urlItem = VRMMockGenerator.createUrlItem()
        var sut = reduce(state: VRMProcessingResult.initial,
                         action: VRMCore.selectInlineVAST(item: urlItem,
                                                          inlineVAST: inlineVAST))
        
        XCTAssertEqual(sut.processedAds.count, 1)
        XCTAssertTrue(sut.processedAds.contains(where: { $0.item == urlItem && $0.inlineVAST == inlineVAST }))
        
        let vastItem = VRMMockGenerator.createVASTItem()
        sut = reduce(state: sut,
                     action: VRMCore.selectInlineVAST(item: vastItem,
                                                      inlineVAST: inlineVAST))
        
        XCTAssertEqual(sut.processedAds.count, 2)
        XCTAssertTrue(sut.processedAds.contains(where: { $0.item == vastItem && $0.inlineVAST == inlineVAST }))
        
        
        sut = reduce(state: sut, action: VRMCore.startGroupProcessing(group: VRMCore.Group(items: [])))
        
        XCTAssertEqual(sut.processedAds.count, 0)
    }
    
    func testAdRequest() {
        let url = URL(string:"http://url.com")!
        let vastItem = VRMMockGenerator.createVASTItem()
        var sut = reduce(state: VRMProcessingResult.initial,
                         action: VRMCore.selectInlineVAST(item: vastItem,
                                                          inlineVAST: inlineVAST))
        
        XCTAssertEqual(sut.processedAds.count, 1)
        
        sut = reduce(state: sut,
                     action: VRMCore.adRequest(url: url, id: UUID(), type: .midroll))
        
        XCTAssertEqual(sut.processedAds.count, 0)
    }
}
