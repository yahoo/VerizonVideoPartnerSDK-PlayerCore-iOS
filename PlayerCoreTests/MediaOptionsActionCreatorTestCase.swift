//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class MediaOptionsActionCreatorTestCase: XCTestCase {
    func test() {
        let option = MediaOptions.Option(uuid: UUID(), displayName: "")
        XCTAssertNotNil(update(availableAudibleOptions: [option]) as? UpdateAvailableAudibleOptions)
        XCTAssertNotNil(update(availableLegibleOptions: [option]) as? UpdateAvailableLegibleOptions)
        XCTAssertNotNil(select(audibleOption: option) as? SelectAudibleOption)
        XCTAssertNotNil(select(legibleOption: option) as? SelectLegibleOption)
    }
}

