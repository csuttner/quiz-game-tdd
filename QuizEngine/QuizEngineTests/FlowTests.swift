//
//  FlowTests.swift
//  QuizEngineTests
//
//  Created by Clay Suttner on 2/7/21.
//

import Foundation
import XCTest

// access to internal types and functions
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    // flow needs to know about router, so it can communicate
    let router = RouterSpy()
    
    // what if we have no questions? we don't want the app to crash
    // also we need a way to start the game
    // no op test
    func test_start_withNoQuestions_doesNotRouteToQuestion() {

        // need something we can start
        // every time we open a test file, we want to see *what am I testing here*
        // sut = system under test
        makeSUT(questions: []).start()
        
        // say we have a router, expect not to route to any question
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    // say we DO have at least one question, want to test this as well
    // should route to question
    // want to make sure we're getting the correct question
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
         
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // second scenario for one question
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
         
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    // multiple questions
    func test_start_withTwoQuestions_routeToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
         
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // starting twice
    func test_startTwice_withTwoQuestions_routeToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()

        // expecting Q1
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    // how to do we go from Q1 to Q2?
    // should have a way of going back
    // want to guarantee for any number of questions
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        // when answer, want to be routed to Q1 and Q2
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")

        // when answer, want to be routed to Q1 and Q2
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // route to result
    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(router.routedResult!, [:])
    }
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")

        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routeToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        // when answer, want to be routed to Q1 and Q2
        XCTAssertEqual(router.routedResult!, ["Q1" : "A1", "Q2" : "A2"])
    }
    
    // MARK: - Helpers
    
    // factory method
    func makeSUT(questions: [String]) -> Flow {
        return Flow(questions: questions, router: router)
    }
    
    // dummy class implementing router protocol so we can test Flow class
    // spy is backing up expectations - progressively growing
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: Router.AnswerCallback = { _ in }
        var routedResult: [String : String]? = nil
        
        // router needs to capture callback so it can fire it
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            routedResult = result
        }
    }
    
}
