//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class MediaOptionsComponentTestCase: XCTestCase {
    func testReduceOnUpdateAvailableAudibleOptions() {
        var sut = MediaOptions.empty
        let options = [MediaOptions.Option(uuid: UUID(), displayName: "test")]
        sut = reduce(state: sut, action: UpdateAvailableAudibleOptions(options: options))
        XCTAssertEqual(sut.unselectedAudibleOptions, options)
    }
    
    func testReduceOnUpdateAvailableLegibleOptions() {
        var sut = MediaOptions.empty
        let options = [MediaOptions.Option(uuid: UUID(), displayName: "test")]
        sut = reduce(state: sut, action: UpdateAvailableLegibleOptions(options: options))
        XCTAssertEqual(sut.unselectedLegibleOptions, options)
    }
    
    func testReduceOnSelectAudibleOption() {
        var sut = MediaOptions.empty
        let option = MediaOptions.Option(uuid: UUID(), displayName: "test")
        sut = reduce(state: sut, action: SelectAudibleOption(option: option))
        XCTAssertEqual(sut.selectedAudibleOption, option)
        sut = reduce(state: sut, action: SelectAudibleOption(option: nil))
        XCTAssertNil(sut.selectedAudibleOption)
    }
    
    func testReduceOnSelectLegibleOption() {
        var sut = MediaOptions.empty
        let option = MediaOptions.Option(uuid: UUID(), displayName: "test")
        sut = reduce(state: sut, action: SelectLegibleOption(option: option))
        XCTAssertEqual(sut.selectedLegibleOption, option)
        sut = reduce(state: sut, action: SelectLegibleOption(option: nil))
        XCTAssertNil(sut.selectedLegibleOption)
    }
}

