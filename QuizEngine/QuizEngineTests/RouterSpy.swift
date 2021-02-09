//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Clay Suttner on 2/9/21.
//

import Foundation
@testable import QuizEngine

// dummy class implementing router protocol so we can test Flow class
// spy is backing up expectations - progressively growing
class RouterSpy: Router {
    typealias Question = String
    typealias Answer = String

    var routedQuestions: [String] = []
    var answerCallback: (String) -> Void = { _ in }
    var routedResult: QuizResult<String, String>? = nil
    
    // router needs to capture callback so it can fire it
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: QuizResult<String, String>) {
        routedResult = result
    }
}
