//
//  Game.swift
//  QuizEngine
//
//  Created by Clay Suttner on 2/9/21.
//

import Foundation

// holds state, no functions
public class Game <R: Router> {
    let flow: Flow<R>
    
    init(flow: Flow<R>) {
        self.flow = flow
    }
    
}

public func startGame<R: Router>(questions: [R.Question], router: R, correctAnswers: [R.Question: R.Answer]) -> Game<R> {
    
    // flow is internal, we don't want to make it public, which is why we have
    // the start game function
    let flow = Flow(questions: questions, router: router, scoring: { scoring($0, correctAnswers: correctAnswers) })
    flow.start()
    return Game(flow: flow)
}
 
private func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswers: [Question: Answer]) -> Int {
    return answers.reduce(0) { (score, tuple) in
        return score + (correctAnswers[tuple.key] == tuple.value ? 1 : 0)
    }
}
