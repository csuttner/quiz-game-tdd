//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Clay Suttner on 2/11/21.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    typealias Question = String
    typealias Answer = String
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }
    
    func routeTo(result: QuizResult<String, String>) {
        
    }
}
