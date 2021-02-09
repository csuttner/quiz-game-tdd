//
//  Result.swift
//  QuizEngine
//
//  Created by Clay Suttner on 2/9/21.
//

import Foundation

public struct QuizResult <Question: Hashable, Answer> {
    public let answers: [Question : Answer]
    public let score: Int
}
