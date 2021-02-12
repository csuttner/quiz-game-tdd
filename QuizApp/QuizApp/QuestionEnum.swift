//
//  Question.swift
//  QuizApp
//
//  Created by Clay Suttner on 2/11/21.
//

import Foundation

enum QuestionEnum<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let value):
            hasher.combine(value)
        case .multipleAnswer(let value):
            hasher.combine(value)
        }
    }
    
    static func ==(lhs: QuestionEnum<T>, rhs: QuestionEnum<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let a), .singleAnswer(let b)):
            return a == b
        case (.multipleAnswer(let a), .multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}
