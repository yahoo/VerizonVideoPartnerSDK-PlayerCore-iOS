//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest
@testable import PlayerCore

class AdVRMManagerComponentTestCase: XCTestCase {
    let defaultFinish = AdVRMManager.VRMRequest.State.FinishResult(transactionID: nil,
                                                                   slot: "",
                                                                   startItems: [],
                                                                   timeoutItems: [],
                                                                   otherErrorItems: [],
                                                                   completeItem: nil)
    
    let emptyMetaInfo = VRMMetaInfo(engineType: nil,
                                    ruleId: nil,
                                    ruleCompanyId: nil,
                                    vendor: "vendor",
                                    name: nil,
                                    cpm: nil)
    
    func testReduceOnAdRequest() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .initial())
        let id = UUID()
        sut = reduce(state: sut, action: AdRequest(url: testUrl, id: id, type: .preroll))
        guard case .progress = sut.request.state else { return XCTFail("Expecting `progress` state here!") }
        XCTAssertEqual(sut.request.id, id)
        XCTAssertEqual(sut.requestsFired, 1)
    }
    
    func testReduceOnSkipAd() {
        let id = UUID()
        var sut = AdVRMManager(timeoutBarrier: 250,
                               requestsFired: 0,
                               request: .init(id: id,
                                              timeout: .afterHard,
                                              state: .finish(defaultFinish)))
        sut = reduce(state: sut, action: SkipAd(id: UUID()))
        XCTAssertEqual(sut.request.id, id)
        XCTAssertEqual(sut.request.timeout, .afterHard)
        guard case .skipped = sut.request.state else { return XCTFail("Expecting `skipped` state here!") }
        guard sut.request.result is AdVRMManager.VRMRequest.State.SkippedResult else { return XCTFail("Result should be as AdVRMManager.VRMRequest.State.SkippedResult") }
    }
    
    func testReduceOnAdPlaybackFailed() {
        let id = UUID()
        var sut = AdVRMManager(timeoutBarrier: 250,
                               requestsFired: 0,
                               request: .init(id: id,
                                              timeout: .afterHard,
                                              state: .finish(defaultFinish)))
        sut = reduce(state: sut, action: AdPlaybackFailed(error: NSError(domain: "", code: 0)))
        XCTAssertEqual(sut.request.id, id)
        XCTAssertEqual(sut.request.timeout, .afterHard)
        guard case .failed = sut.request.state else { return XCTFail("Expecting `failed` state here!") }
        guard sut.request.result is AdVRMManager.VRMRequest.State.FailedResult else { return XCTFail("Result should be as AdVRMManager.VRMRequest.State.SkippedResult") }
    }
    
    func testReduceOnShowAd() {
        let id = UUID()
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: id,
                                              timeout: .afterHard,
                                              state: .finish(defaultFinish)))
        sut = reduce(state: sut, action: ShowAd(creative: .mp4([AdCreative.mp4(with: testUrl)]), id: UUID(), adVerifications: [], isOpenMeasurementEnabled: true))
        XCTAssertEqual(sut.request.id, id)
        XCTAssertEqual(sut.request.timeout, .afterHard)
        guard case .finish = sut.request.state else { return XCTFail("Expecting `ready` state here!") }
    }
    
    func testReduceOnProcessGroups() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: UUID(),
                                              timeout: .beforeSoft,
                                              state: .progress))
        sut = reduce(state: sut, action: ProcessGroups(transactionId: "txid", slot: "slot"))
        guard case .finish(let request) = sut.request.state else { return XCTFail("Expecting `finish` state here!") }
        XCTAssertEqual(request.transactionID, "txid")
        XCTAssertEqual(request.slot, "slot")
    }
    
    func testReduceOnVRMItemStart() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: UUID(),
                                              timeout: .beforeSoft,
                                              state: .finish(defaultFinish)))
        
        let date = Date()
        sut = reduce(state: sut, action: VRMItem.start(.init(info: emptyMetaInfo,
                                                             url: testUrl,
                                                             requestDate: date)))
        if case .finish(let request) = sut.request.state {
            XCTAssertEqual(request.startItems.count, 1)
            let startItem = request.startItems.first
            XCTAssertEqual(startItem?.info.vendor, "vendor")
            XCTAssertEqual(startItem?.url, testUrl)
            XCTAssertEqual(startItem?.requestDate, date)
        } else {
            XCTFail("Expecting `finish` state here!")
        }
    }
    
    func testReduceOnVRMItemModel() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: UUID(),
                                              timeout: .beforeSoft,
                                              state: .finish(defaultFinish)))
        let requestDate = Date()
        let responseDate = requestDate.addingTimeInterval(1)
        
        sut = reduce(state: sut, action: VRMItem.model(.init(adId: "adId",
                                                             info: emptyMetaInfo,
                                                             model: .model(withMp4: [.video(with: testUrl)], andVpaid: []),
                                                             requestDate: requestDate,
                                                             responseDate: responseDate)))
        if case .finish(let request) = sut.request.state {
            XCTAssertNotNil(request.completeItem)
            let completeItem = request.completeItem
            XCTAssertEqual(completeItem?.info.vendor, "vendor")
            XCTAssertNil(completeItem?.transactionID)
            XCTAssertEqual(completeItem?.timeout, .beforeSoft)
            XCTAssertEqual(completeItem?.responseTime, 1000)
            XCTAssertEqual(completeItem?.requestTimeoutBarrier, 3500)
        } else {
            XCTFail("Expecting `finish` state here!")
        }
        
        sut.request.timeout = .afterHard
        sut = reduce(state: sut, action: VRMItem.model(.init(adId: "adId",
                                                             info: emptyMetaInfo,
                                                             model: .model(withMp4: [.video(with: testUrl)], andVpaid: []),
                                                             requestDate: requestDate,
                                                             responseDate: responseDate)))
        if case .finish(let request) = sut.request.state {
            XCTAssertEqual(request.timeoutItems.count, 1)
            let timeoutItem = request.timeoutItems.first
            XCTAssertEqual(timeoutItem?.info.vendor, "vendor")
            XCTAssertNil(timeoutItem?.transactionID)
            XCTAssertEqual(timeoutItem?.timeout, .afterHard)
            XCTAssertEqual(timeoutItem?.responseTime, 1000)
            XCTAssertEqual(timeoutItem?.requestTimeoutBarrier, 3500)
        } else {
            XCTFail("Expecting `finish` state here!")
        }
    }
    
    func testReduceOnVRMItemTimeout() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: UUID(),
                                              timeout: .beforeSoft,
                                              state: .finish(defaultFinish)))
        let requestDate = Date()
        let responseDate = requestDate.addingTimeInterval(1)
        sut = reduce(state: sut, action: VRMItem.timeout(.init(info: emptyMetaInfo,
                                                               requestDate: requestDate,
                                                               responseDate: responseDate)))
        if case .finish(let request) = sut.request.state {
            XCTAssertEqual(request.timeoutItems.count, 1)
            let timeoutItem = request.timeoutItems.first
            XCTAssertEqual(timeoutItem?.info.vendor, "vendor")
            XCTAssertNil(timeoutItem?.transactionID)
            XCTAssertEqual(timeoutItem?.timeout, .beforeSoft)
            XCTAssertEqual(timeoutItem?.responseTime, 1000)
            XCTAssertEqual(timeoutItem?.requestTimeoutBarrier, 3500)
        } else {
            XCTFail("Expecting `finish` state here!")
        }
    }
    
    func testReduceInVRMItemOther() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: UUID(),
                                              timeout: .beforeSoft,
                                              state: .finish(defaultFinish)))
        let requestDate = Date()
        let responseDate = requestDate.addingTimeInterval(1)
        sut = reduce(state: sut, action: VRMItem.other(.init(info: emptyMetaInfo,
                                                             error: nil,
                                                             requestDate: requestDate,
                                                             responseDate: responseDate)))
        if case .finish(let request) = sut.request.state {
            XCTAssertEqual(request.otherErrorItems.count, 1)
            let otherError = request.otherErrorItems.first
            XCTAssertEqual(otherError?.info.vendor, "vendor")
            XCTAssertNil(otherError?.transactionID)
            XCTAssertEqual(otherError?.timeout, .beforeSoft)
            XCTAssertEqual(otherError?.responseTime, 1000)
        } else {
            XCTFail("Expecting `finish` state here!")
        }
    }
    
    func testReduceOnSoftTimeout() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .initial())
        sut = reduce(state: sut, action: SoftTimeout())
        XCTAssertEqual(sut.request.timeout, .afterSoft)
    }
    
    func testReduceOnHardTimeout() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .initial())
        sut = reduce(state: sut, action: HardTimeout())
        XCTAssertEqual(sut.request.timeout, .afterHard)
    }
    func testReduceOnAdStopped() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: UUID(),
                                              timeout: .beforeSoft,
                                              state: .finish(defaultFinish)))
        sut = reduce(state: sut, action: AdStopped())
        XCTAssertEqual(sut.request.id, nil)
        XCTAssertEqual(sut.request.timeout, .beforeSoft)
    }
    func testResponseTimeFunction() {
        let start = Date()
        XCTAssertEqual(responseTime(from: start, end: start.addingTimeInterval(5)), 5000)
        XCTAssertEqual(responseTime(from: start, end: start.addingTimeInterval(1.2)), 1200)
        XCTAssertEqual(responseTime(from: start, end: start.addingTimeInterval(0.7)), 700)
        XCTAssertEqual(responseTime(from: start, end: start.addingTimeInterval(0)), 0)
    }
    
    func testReduceOnAdMaxShowTimeout() {
        var sut = AdVRMManager(timeoutBarrier: 3500,
                               requestsFired: 0,
                               request: .init(id: UUID(),                                              
                                              timeout: .beforeSoft,
                                              state: .finish(defaultFinish)))
        sut = reduce(state: sut, action: AdMaxShowTimeout())
        XCTAssertEqual(sut.request.id, nil)
        XCTAssertEqual(sut.request.timeout, .beforeSoft)
    }
}
