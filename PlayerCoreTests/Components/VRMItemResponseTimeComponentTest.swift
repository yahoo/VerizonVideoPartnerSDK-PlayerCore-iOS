//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMItemResponseTimeComponentTest: XCTestCase {
    
    let startAt = Date(timeIntervalSince1970: 0)
    let finishedAt = Date(timeIntervalSince1970: 2)
    
    func testSaveStartTimeOnStartFetching() {
        let item = VRMMockGenerator.createUrlItem()
        let url = URL(string: "http://test.com")!
        let action = VRMCore.startItemFetch(originalItem: item, url: url, startDate: startAt)
        
        let sut = reduce(state: VRMItemResponseTime.initial, action: action)
        
        let range = sut.timeRangeContainer[item]
        XCTAssertNotNil(range)
        XCTAssertNil(range?.finishAt)
        XCTAssertEqual(range?.startAt, startAt)
    }
    
    func testSaveStartTimeOnStartParsing() {
        let item = VRMMockGenerator.createUrlItem()
        let action = VRMCore.startItemParsing(originalItem: item, vastXML: "", startDate: startAt)
        
        let sut = reduce(state: VRMItemResponseTime.initial, action: action)
        
        let range = sut.timeRangeContainer[item]
        XCTAssertNotNil(range)
        XCTAssertNil(range?.finishAt)
        XCTAssertEqual(range?.startAt, startAt)
    }
    
    func testIgnoreParsingForSameItem() {
        let startParsingAt = Date(timeIntervalSince1970: 1)
        let item = VRMMockGenerator.createUrlItem()
        let initialRange = VRMItemResponseTime.TimeRange(startAt: startAt,
                                                         finishAt: nil)
        let initial = VRMItemResponseTime(timeRangeContainer: [item: initialRange])
        
        let sut = reduce(state: initial, action: VRMCore.startItemParsing(originalItem: item,
                                                                          vastXML: "", startDate: startParsingAt))
        
        let range = sut.timeRangeContainer[item]
        XCTAssertNotNil(range)
        XCTAssertNil(range?.finishAt)
        XCTAssertEqual(range?.startAt, startAt)
    }
    
    func testSetFinishTimeOnProcessingComplete() {
        let initialRange = VRMItemResponseTime.TimeRange(startAt: startAt,
                                                         finishAt: nil)
        let item = VRMMockGenerator.createUrlItem()
        let initial = VRMItemResponseTime(timeRangeContainer: [item: initialRange])
        let vast = VRMMockGenerator.createVASTAdModel()
        let selectInline = VRMCore.selectInlineVAST(item: item, inlineVAST: vast, date: finishedAt)
        
        let sut = reduce(state: initial, action: selectInline)
        
        let resultRange = sut.timeRangeContainer[item]
        
        XCTAssertNotNil(resultRange)
        XCTAssertEqual(resultRange?.startAt, startAt)
        XCTAssertEqual(resultRange?.finishAt, finishedAt)
    }
    
    func testSetFinishOnError() {
        let initialRange = VRMItemResponseTime.TimeRange(startAt: startAt,
                                                         finishAt: nil)
        let item = VRMMockGenerator.createUrlItem()
        let initial = VRMItemResponseTime(timeRangeContainer: [item: initialRange])
        
        let failedParseAction =  VRMCore.failedItemParse(originalItem: item, finishDate: finishedAt)
        let failedFetchAction = VRMCore.failedItemFetch(originalItem: item, finishDate: finishedAt)
        let indirectionsAction = VRMCore.tooManyIndirections(item: item, finishDate: finishedAt)
        
        [failedParseAction,
         failedFetchAction,
         indirectionsAction
        ].forEach { action in
            let sut = reduce(state: initial, action: action)
            let resultRange = sut.timeRangeContainer[item]
            
            XCTAssertNotNil(resultRange, "action \(action) removed time info for item")
            XCTAssertEqual(resultRange?.startAt, startAt)
            XCTAssertEqual(resultRange?.finishAt, finishedAt, "action \(type(of: action)) set wrong finish date")
        }
    }
    
    func testFinishAtHardTimeout() {
        let initialRange1 = VRMItemResponseTime.TimeRange(startAt: startAt,
                                                         finishAt: nil)
        let initialRange2 = VRMItemResponseTime.TimeRange(startAt: startAt,
                                                         finishAt: nil)
        let item1 = VRMMockGenerator.createUrlItem()
        let item2 = VRMMockGenerator.createUrlItem()
        let initial = VRMItemResponseTime(timeRangeContainer: [item1: initialRange1,
                                                               item2: initialRange2])

        let hardTimeout = VRMCore.hardTimeoutReached(items: [item1, item2], date: finishedAt)
        
        let sut = reduce(state: initial, action: hardTimeout)
        
        XCTAssertEqual(sut.timeRangeContainer.count, 2)
        sut.timeRangeContainer.forEach { key, value in
            XCTAssertEqual(value.startAt, startAt)
            XCTAssertEqual(value.finishAt, finishedAt)
        }
    }
}
