//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.


import XCTest
@testable import PlayerCore

class VPAIDErrorsReducerTest: XCTestCase {
    
    let initialState = VPAIDErrors(abusedEvents: [],
                                   javaScriptEvaluationErrors: [],
                                   isAdNotSupported: false )
    
    struct TestError: Error {
        let name: String
    }
    
    func testJSError() {
        let testError1 = TestError(name: "error1")
        let testError2 = TestError(name: "error2")

        var state = reduce(state: initialState, action: AdJavaScriptEvaluationError(error: testError1))
        guard let error1 = state.javaScriptEvaluationErrors.last as? TestError else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(testError1.name, error1.name)
        XCTAssertTrue(state.abusedEvents.isEmpty)
        
        state = reduce(state: state, action: AdJavaScriptEvaluationError(error: testError2))
        guard let error2 = state.javaScriptEvaluationErrors.last as? TestError else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(testError2.name, error2.name)
        XCTAssertTrue(state.abusedEvents.isEmpty)
    }
    
    func testUniqueEventAbuse() {
        let abuse1 = VPAIDErrors.UniqueEventError(eventName: "eventName1", eventValue: nil)
        let abuse2 = VPAIDErrors.UniqueEventError(eventName: "eventName2", eventValue: nil)
        
        var state = reduce(state: initialState, action: AdUniqueEventAbuse(name: abuse1.eventName, value: abuse1.eventValue))
        guard let error1 = state.abusedEvents.last else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(abuse1.eventName, error1.eventName)
        XCTAssertTrue(state.javaScriptEvaluationErrors.isEmpty)
        
        state = reduce(state: state, action: AdUniqueEventAbuse(name: abuse2.eventName, value: abuse2.eventValue))
        guard let error2 = state.abusedEvents.last else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(abuse2.eventName, error2.eventName)
        XCTAssertTrue(state.javaScriptEvaluationErrors.isEmpty)
    }
    
    func testUnsupportedVPAIDError() {
        let state = reduce(state: initialState, action: AdNotSupported())
        XCTAssertTrue(state.isAdNotSupported)
    }
    
    func testClearErrorState() {
        let abuse = VPAIDErrors.UniqueEventError(eventName: "eventName", eventValue: nil)
        let testError = TestError(name: "error")
        var state = initialState
        
        let actionsWhichClearState: [Action] = [
            DropAd(id: UUID()),
            AdStopped(),
            ShowContent(),
            SelectVideoAtIdx(idx: 1, id: UUID(), hasPrerollAds: true, midrolls: [])
        ]
        
        actionsWhichClearState.forEach { clearStateAction in
            state = reduce(state: state, action: AdJavaScriptEvaluationError(error: testError))
            state = reduce(state: state, action: AdUniqueEventAbuse(name: abuse.eventName, value: abuse.eventValue))
            
            XCTAssertFalse(state.abusedEvents.isEmpty)
            XCTAssertFalse(state.javaScriptEvaluationErrors.isEmpty)
            
            state = reduce(state: state, action: clearStateAction)
            
            XCTAssertTrue(state.abusedEvents.isEmpty, "state didn't reflect at \(clearStateAction)")
            XCTAssertTrue(state.javaScriptEvaluationErrors.isEmpty, "state didn't reflect at \(clearStateAction)")
            XCTAssertFalse(state.isAdNotSupported, "state didn't reflect at \(clearStateAction)")
        }
    }
}
