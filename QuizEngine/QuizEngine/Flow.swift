//
//  Flow.swift
//  QuizEngine
//
//  Created by Clay Suttner on 2/7/21.
//

import Foundation

// different implementations for iOS, TVOS, etc
protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question : Answer])
}

// why is this a class?
// --- plain data we're passing around? (struct)
// --- or more like behavior? (class)
class Flow <R: Router> {
    
    // we need a router - type to use to communicate
    // could have many implementations, therefore it's a protocol
    private let router: R
    private let questions: [R.Question]
    private var result: [R.Question : R.Answer] = [:]
    
    // could have multiple questions -> array
    init(questions: [R.Question], router: R) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallback(from question: R.Question) -> (R.Answer) -> Void {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: R.Question, _ answer: R.Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
                
            } else {
                router.routeTo(result: result)
            }
        }
    }
}
