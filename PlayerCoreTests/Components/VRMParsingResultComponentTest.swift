//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMParsingResultComponentTest: XCTestCase {
    
    let urlItem = VRMMockGenerator.createUrlItem()
    let vastItem = VRMMockGenerator.createVASTItem()
    
    let tag1URL = URL(string: "http://tag1.com")!
    let impression1 = URL(string:"http://impression1.com")!
    let adVerification1 = Ad.VASTModel.AdVerification(vendorKey: "vendorKey",
                                                      javaScriptResource: URL(string:"http://javaScriptResource1.com")!,
                                                      verificationParameters: nil,
                                                      verificationNotExecuted: nil)
    
    let tag2URL = URL(string: "http://tag2.com")!
    let impression2 = URL(string:"http://impression2.com")!
    let adVerification2 = Ad.VASTModel.AdVerification(vendorKey: "vendorKey",
                                                      javaScriptResource: URL(string:"http://javaScriptResource2.com")!,
                                                      verificationParameters: nil,
                                                      verificationNotExecuted: nil)
    
    let impression3 = URL(string:"http://impression3.com")!
    let adVerification3 = Ad.VASTModel.AdVerification(vendorKey: "vendorKey",
                                                      javaScriptResource: URL(string:"http://javaScriptResource3.com")!,
                                                      verificationParameters: nil,
                                                      verificationNotExecuted: nil)
    
    func testTwoItems() {
        var sut = VRMParsingResult.initial
        let wrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag1URL,
                                                     adVerifications: [adVerification1],
                                                     pixels: AdPixels(impression: [impression1]))
        
        let adVAST = Ad.VASTModel(adVerifications: [],
                                  mediaFiles: [],
                                  clickthrough: nil,
                                  adParameters: nil,
                                  pixels: AdPixels(),
                                  id: "")
        
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: urlItem,
                                                                     vastModel: .wrapper(wrapper)))
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: vastItem,
                                                                     vastModel: .inline(adVAST)))
        XCTAssertEqual(sut.parsedVASTs[urlItem], .wrapper(wrapper))
        XCTAssertEqual(sut.parsedVASTs[vastItem], .inline(adVAST))
    }
    
    func testSecondWrapperForSameItem() {
        let wrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag1URL,
                                                     adVerifications: [adVerification1],
                                                     pixels: AdPixels(impression: [impression1]))
        
        var sut = VRMParsingResult(parsedVASTs: [urlItem: .wrapper(wrapper)])
        
        let secondWrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag2URL,
                                                          adVerifications: [adVerification2],
                                                          pixels: AdPixels(impression: [impression2]))
        
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: urlItem,
                                                                     vastModel: .wrapper(secondWrapper)))
        
        if let vastModel = sut.parsedVASTs[urlItem],
            case .wrapper(let mergedWrapper) = vastModel {
            XCTAssertEqual(mergedWrapper.pixels.impression, [impression2, impression1])
            XCTAssertEqual(mergedWrapper.adVerifications, [adVerification2, adVerification1])
            XCTAssertEqual(mergedWrapper.tagURL, tag2URL)
            
        } else {
            XCTFail()
        }
    }
    
    func testInlineModelAfterWrarppers() {
        let wrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag1URL,
                                                     adVerifications: [adVerification2, adVerification1],
                                                     pixels: AdPixels(impression: [impression2, impression1]))
        
        var sut = VRMParsingResult(parsedVASTs: [urlItem: .wrapper(wrapper)])
        
        let adVAST = Ad.VASTModel(adVerifications: [adVerification3],
                                  mediaFiles: [],
                                  clickthrough: nil,
                                  adParameters: nil,
                                  pixels: AdPixels(impression: [impression3]),
                                  id: "")
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: urlItem,
                                                                     vastModel: .inline(adVAST)))
        
        if let vastModel = sut.parsedVASTs[urlItem],
            case .inline(let adModel) = vastModel {
            XCTAssertEqual(adModel.pixels.impression, [impression3, impression2, impression1])
            XCTAssertEqual(adModel.adVerifications, [adVerification3, adVerification2, adVerification1])
            
        } else {
            XCTFail()
        }
    }
}
