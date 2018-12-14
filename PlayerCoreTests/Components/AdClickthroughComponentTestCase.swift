//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdClickthroughComponentTestCase: XCTestCase {
    func testReduce() {
        let initial = AdClickthrough(isPresentationRequested: false)
        
        var sut = reduce(state: initial, action: RequestClickthroughAdPresentation())
        XCTAssertEqual(sut.isPresentationRequested, true)
        
        sut = reduce(state: sut, action: DidShowAdClickthrough())
        XCTAssertEqual(sut.isPresentationRequested, true)
        
        sut = reduce(state: sut, action: DidHideAdClickthrough(isAdVPAID: false))
        XCTAssertEqual(sut.isPresentationRequested, false)
    }
}
