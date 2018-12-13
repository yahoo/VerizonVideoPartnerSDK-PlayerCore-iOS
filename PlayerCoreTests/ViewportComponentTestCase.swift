//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class ViewportComponentTestCase: XCTestCase {
    let initial = Viewport(dimensions: nil, camera: .init(horizontal: 0, vertical: 0))
    
    func testReduceOnAttachToViewport() {
        let size = CGSize(width: 100, height: 100)
        let sut = reduce(state: initial, action: AttachToViewport(dimensions: size))
        XCTAssertEqual(sut.dimensions, size)
    }
    
    func testReduceOnUpdateViewportDimensions() {
        let size = CGSize(width: 50, height: 50)
        let sut = reduce(state: initial, action: UpdateViewportDimensions(newSize: size))
        XCTAssertEqual(sut.dimensions, size)
    }
    
    func testReduceOnDetachFromViewport() {
        let sut = reduce(state: initial, action: DetachFromViewport())
        XCTAssertEqual(sut.dimensions, nil)
    }
    
    func testReduceOnUpdateCameraAngles() {
        let sut = reduce(state: initial, action: UpdateCameraAngles(horizontal: 50.0, vertical: 100.0))
        XCTAssertEqual(sut.dimensions, nil)
        XCTAssertEqual(sut.camera.horizontal, 50.0)
        XCTAssertEqual(sut.camera.vertical, 100.0)
    }
    
    func testReduceOnOtherActions() {
        let sut = reduce(state: initial, action: Play(time: .init()))
        XCTAssertEqual(sut.dimensions, nil)
    }
}
