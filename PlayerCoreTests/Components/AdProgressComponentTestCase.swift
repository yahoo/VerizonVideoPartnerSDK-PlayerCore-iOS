//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdProgressComponentTestCase: XCTestCase {
    let initial = AdVASTProgress(pixels: [])
    
    let timeProgress = Ad.VASTModel.AdProgress(url: testUrl, offset: Ad.VASTModel.VASTOffset.time(15))
    let percentageProgress = Ad.VASTModel.AdProgress(url: testUrl, offset: Ad.VASTModel.VASTOffset.percentage(50))
    
    func testReducer() {
        var sut = reduce(state: initial, action: UpdateAdDuration(newDuration: nil, vastAdProgress: [timeProgress]))
        XCTAssertTrue(sut.pixels.isEmpty)
        
        sut = reduce(state: sut, action: UpdateAdDuration(newDuration: toCMTime(60), vastAdProgress: []))
        XCTAssertTrue(sut.pixels.isEmpty)
        
        sut = reduce(state: sut, action: UpdateAdDuration(newDuration: toCMTime(60), vastAdProgress: [timeProgress]))
        XCTAssertEqual(sut.pixels.first?.offsetInSeconds, 15)
        
        sut = reduce(state: sut, action: UpdateAdDuration(newDuration: toCMTime(60), vastAdProgress: [percentageProgress]))
        XCTAssertEqual(sut.pixels.first?.offsetInSeconds, 30)
        
        sut = reduce(state: sut, action: AdRequest(url: testUrl, id: UUID(), type: .midroll))
        XCTAssertTrue(sut.pixels.isEmpty)
    }
}

