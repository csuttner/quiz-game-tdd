//
//  Result.swift
//  QuizEngine
//
//  Created by Clay Suttner on 2/9/21.
//

import Foundation

public class QuizResult <Question: Hashable, Answer> {
    public var answers = [Question : Answer]()
    public var score = Int()
    
    public init(answers: [Question : Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
