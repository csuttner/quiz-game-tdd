//
//  GameTests.swift
//  QuizEngineTests
//
//  Created by Clay Suttner on 2/9/21.
//

import Foundation
import XCTest
@testable import QuizEngine

class GameTests: XCTestCase {
    
    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        let router = RouterSpy()
        startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
        
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResult!.score, 1)
    }
    
}
