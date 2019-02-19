//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class VRMProcessingTimeComponentTest: XCTestCase {
    
    let url = URL(string: "http://test.com")!
    
    func testStartProcessingOldCore() {
        let initial = VRMProcessingTime.initial
        
        let sut = reduce(state: initial, action: adRequest(url: url, id: UUID(), type: .preroll))
        guard case .inProgress = sut else { XCTFail("on adRequest sut should be .inProgress, actual \(sut)"); return }
    }
    
    func testStartProcessingNewCore() {
        let initial = VRMProcessingTime.initial
        
        let sut = reduce(state: initial, action: VRMCore.adRequest(url: url, id: UUID(), type: .preroll))
        guard case .inProgress = sut else { XCTFail("on VRMCore.adRequest sut should be .inProgress, actual \(sut)"); return }
    }
    
    func testFinishMP4Processing() {
        let initialDate = Date()
        let mp4 = AdCreative.MP4(internalID: UUID(),
                                 url: url,
                                 clickthrough: url,
                                 pixels: AdPixels(),
                                 id: "",
                                 width: 30,
                                 height: 30,
                                 scalable: false,
                                 maintainAspectRatio: true)
        let initial = VRMProcessingTime.inProgress(startAt: initialDate)
        
        let sut = reduce(state: initial, action: showMP4Ad(creative: mp4, id: UUID()))
        guard case let .finished(startAt, _) = sut else { XCTFail("on showMP4Ad sut should be .finished, actual \(sut)"); return }
        XCTAssertEqual(initialDate, startAt)
    }
    
    func testFinishVPAIDProcessing() {
        let initialDate = Date()
        let vpaid = AdCreative.VPAID(internalID: UUID(),
                                   url: url,
                                   adParameters: nil,
                                   clickthrough: nil,
                                   pixels: .init(),
                                   id: nil)
        let initial = VRMProcessingTime.inProgress(startAt: initialDate)
        
        let sut = reduce(state: initial, action: showVPAIDAd(creative: vpaid, id: UUID()))
        guard case let .finished(startAt, _) = sut else { XCTFail("on showVPAIDAd sut should be .finished, actual \(sut)"); return }
        XCTAssertEqual(initialDate, startAt)
    }
    
    func testMaxAdSearchTime() {
        let initial = VRMProcessingTime.inProgress(startAt: Date())
        
        let sut = reduce(state: initial, action: VRMCore.maxSearchTimeoutReached(requestID: UUID()))
        guard case .empty = sut else { XCTFail("on maxSearchTimeoutReached sut should be .empty, actual \(sut)"); return }
    }
    
    func testFailedProcessing() {
        let initial = VRMProcessingTime.inProgress(startAt: Date())
        
        let sut = reduce(state: initial, action: VRMCore.noGroupsToProcess(id: UUID()))
        guard case .empty = sut else { XCTFail("on noGroupsToProcess sut should be .empty, actual \(sut)"); return }
    }
    
    func testFailedToGetVRMResponse() {
        let initial = VRMProcessingTime.inProgress(startAt: Date())
        
        let sut = reduce(state: initial, action: VRMCore.adResponseFetchFailed(requestID: UUID()))
        guard case .empty = sut else { XCTFail("on adResponseFetchFailed sut should be .empty, actual \(sut)"); return }
    }
}
