//
//  Router.swift
//  QuizEngine
//
//  Created by Clay Suttner on 2/9/21.
//

import Foundation

// different implementations for iOS, TVOS, etc
public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer: Equatable
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: QuizResult<Question, Answer>)
}
