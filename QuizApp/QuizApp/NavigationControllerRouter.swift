//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Clay Suttner on 2/11/21.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: QuestionEnum<String>, answerCallback: @escaping (String) -> Void) -> UIViewController
    func resultViewController(for result: QuizResult<QuestionEnum<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {
    typealias Question = QuestionEnum<String>
    typealias Answer = String
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question , answerCallback: @escaping (String) -> Void) {
        show(factory.questionViewController(for: question, answerCallback: answerCallback))
    }
    
    func routeTo(result: QuizResult<Question, String>) {
        show(factory.resultViewController(for: result))
        
    }
    
    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
