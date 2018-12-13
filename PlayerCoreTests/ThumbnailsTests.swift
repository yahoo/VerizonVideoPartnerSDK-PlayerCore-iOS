//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class ThumbnailsTests: XCTestCase {
    func testShouldPreferCloserToTheOriginalIfNoBiggerAvailable() {
        
        let items = [
            (25, 25, URL(string: "http://test1.com")!),
            (35, 50, URL(string: "http://test2.com")!),
            (10, 10, URL(string: "http://test3.com")!)
        ].map(Thumbnail.init)
        
        let thumbnail = Model.Video.Thumbnail(items: items)!
        
        XCTAssertEqual(thumbnail[CGSize(width: 50, height: 50)].absoluteString, "http://test2.com")
        XCTAssertEqual(thumbnail[CGSize(width: 35, height: 50)].absoluteString, "http://test2.com")
    }
    
    func testShouldPreferBiggestThumbnail() {
        let items = [
            (50, 50, URL(string: "http://test3.com")!),
            (100, 100, URL(string: "http://test1.com")!),
            (100, 150, URL(string: "http://test2.com")!),
            (200, 300, URL(string: "http://test4.com")!)
        ].map(Thumbnail.init)
        
        let thumbnail = Model.Video.Thumbnail(items: items)!
        
        XCTAssertEqual(thumbnail[CGSize(width: 50, height: 50)].absoluteString, "http://test4.com")
    }    
}
