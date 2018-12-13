//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class ClickThroughActionCreatorTestCase: XCTestCase {
    func test() {
        XCTAssertNotNil(PlayerCore.requestClickthroughAdPresentation() as? RequestClickthroughAdPresentation)
        XCTAssertNotNil(PlayerCore.didShowAdClickthrough() as? DidShowAdClickthrough)
        XCTAssertNotNil(PlayerCore.didHideAdClickthrough(isAdVPAID: false) as? DidHideAdClickthrough)
    }
}
