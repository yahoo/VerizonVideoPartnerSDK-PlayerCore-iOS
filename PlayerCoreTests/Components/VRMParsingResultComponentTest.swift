//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMParsingResultComponentTest: XCTestCase {
    
    let urlItem = VRMMockGenerator.createUrlItem()
    let vastItem = VRMMockGenerator.createVASTItem()
    
    let tag1URL = URL(string: "http://tag1.com")!
    let impression1 = URL(string:"http://impression1.com")!
    let adProgress1 = Ad.VASTModel.AdProgress(url: URL(string: "http://test1")!, offset: .time(5))
    let adVerification1 = Ad.VASTModel.AdVerification(vendorKey: "vendorKey",
                                                      javaScriptResource: URL(string:"http://javaScriptResource1.com")!,
                                                      verificationParameters: nil,
                                                      verificationNotExecuted: nil)
    
    let tag2URL = URL(string: "http://tag2.com")!
    let impression2 = URL(string:"http://impression2.com")!
    let adProgress2 = Ad.VASTModel.AdProgress(url: URL(string: "http://test2")!, offset: .time(10))
    let adVerification2 = Ad.VASTModel.AdVerification(vendorKey: "vendorKey",
                                                      javaScriptResource: URL(string:"http://javaScriptResource2.com")!,
                                                      verificationParameters: nil,
                                                      verificationNotExecuted: nil)
    
    let impression3 = URL(string:"http://impression3.com")!
    let adProgress3 = Ad.VASTModel.AdProgress(url: URL(string: "http://test3")!, offset: .percentage(32))
    let adVerification3 = Ad.VASTModel.AdVerification(vendorKey: "vendorKey",
                                                      javaScriptResource: URL(string:"http://javaScriptResource3.com")!,
                                                      verificationParameters: nil,
                                                      verificationNotExecuted: nil)
    
    func testTwoItemsAndCleanOnNextAdRequest() {
        var sut = VRMParsingResult.initial
        let wrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag1URL,
                                                     adVerifications: [adVerification1],
                                                     pixels: AdPixels(impression: [impression1]),
                                                     adProgress: [adProgress1])
        
        let adVAST = Ad.VASTModel(adVerifications: [],
                                  mp4MediaFiles: [],
                                  vpaidMediaFiles: [],
                                  skipOffset: .none,
                                  clickthrough: nil,
                                  adParameters: nil,
                                  adProgress: [],
                                  pixels: AdPixels(),
                                  id: "")
        
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: urlItem,
                                                                     vastModel: .wrapper(wrapper)))
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: vastItem,
                                                                     vastModel: .inline(adVAST)))
        XCTAssertEqual(sut.parsedVASTs[urlItem]?.vastModel, .wrapper(wrapper))
        XCTAssertEqual(sut.parsedVASTs[vastItem]?.vastModel, .inline(adVAST))
        
        sut = reduce(state: sut, action: VRMCore.adRequest(url: URL(string:"url")!, id: UUID(), type: .midroll))
        XCTAssertTrue(sut.parsedVASTs.isEmpty)
    }
    
    func testSecondWrapperForSameItem() {
        let wrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag1URL,
                                                     adVerifications: [adVerification1],
                                                     pixels: AdPixels(impression: [impression1]),
                                                     adProgress: [adProgress1])
        let initialResult = VRMParsingResult.Result(vastModel: .wrapper(wrapper))
        var sut = VRMParsingResult(parsedVASTs: [urlItem: initialResult])
        
        let secondWrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag2URL,
                                                          adVerifications: [adVerification2],
                                                          pixels: AdPixels(impression: [impression2]),
                                                          adProgress: [adProgress2])
        
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: urlItem,
                                                                     vastModel: .wrapper(secondWrapper)))
        
        if let result = sut.parsedVASTs[urlItem],
            case .wrapper(let mergedWrapper) = result.vastModel {
            XCTAssertNotEqual(result.id, initialResult.id)
            XCTAssertEqual(mergedWrapper.pixels.impression, [impression2, impression1])
            XCTAssertEqual(mergedWrapper.adVerifications, [adVerification2, adVerification1])
            XCTAssertEqual(mergedWrapper.tagURL, tag2URL)
            XCTAssertEqual(mergedWrapper.adProgress, [adProgress2, adProgress1])
            
        } else {
            XCTFail()
        }
    }
    
    func testInlineModelAfterWrappers() {
        let wrapper = VRMCore.VASTModel.WrapperModel(tagURL: tag1URL,
                                                     adVerifications: [adVerification2, adVerification1],
                                                     pixels: AdPixels(impression: [impression2, impression1]),
                                                     adProgress: [adProgress2, adProgress1])
        
        let initialResult = VRMParsingResult.Result(vastModel: .wrapper(wrapper))
        var sut = VRMParsingResult(parsedVASTs: [urlItem: initialResult])
        
        let adVAST = Ad.VASTModel(adVerifications: [adVerification3],
                                  mp4MediaFiles: [],
                                  vpaidMediaFiles: [],
                                  skipOffset: .none,
                                  clickthrough: nil,
                                  adParameters: nil,
                                  adProgress: [adProgress3],
                                  pixels: AdPixels(impression: [impression3]),
                                  id: "")
        sut = reduce(state: sut, action: VRMCore.completeItemParsing(originalItem: urlItem,
                                                                     vastModel: .inline(adVAST)))
        
        if let result = sut.parsedVASTs[urlItem],
            case .inline(let adModel) = result.vastModel {
            XCTAssertNotEqual(result.id, initialResult.id)
            XCTAssertEqual(adModel.pixels.impression, [impression3, impression2, impression1])
            XCTAssertEqual(adModel.adVerifications, [adVerification3, adVerification2, adVerification1])
            XCTAssertEqual(adModel.adProgress, [adProgress3, adProgress2, adProgress1])
            
        } else {
            XCTFail()
        }
    }
}
