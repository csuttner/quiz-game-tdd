//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Clay Suttner on 2/11/21.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()
    
    func test_routeToQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: QuestionEnum.singleAnswer("Q1"), with: viewController)
        factory.stub(question: QuestionEnum.singleAnswer("Q2"), with: secondViewController)

        sut.routeTo(question: QuestionEnum.singleAnswer("Q1")) { _ in }
        sut.routeTo(question: QuestionEnum.singleAnswer("Q2")) { _ in }
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToQuestion_presentsQuestionWithRightCallback() {
        var callbackWasFired = false
        sut.routeTo(question: QuestionEnum.singleAnswer("Q1")) { _ in callbackWasFired = true }
        factory.answerCallback[QuestionEnum.singleAnswer("Q1")]!("anything")
        
        XCTAssertTrue(callbackWasFired)
    }
    
    func test_routeToResult_showsResultController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        let result = QuizResult(answers: [QuestionEnum.singleAnswer("Q1"): "A1"], score: 10)
        let secondResult = QuizResult(answers: [QuestionEnum.singleAnswer("Q2"): "A2"], score: 20)
        
        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)

        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = [QuestionEnum<String> : UIViewController]()
        private var stubbedResults = [QuizResult<QuestionEnum<String>, String> : UIViewController]()
        var answerCallback = [QuestionEnum<String> : (String) -> Void]()
        
        func stub(question: QuestionEnum<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func stub(result: QuizResult<QuestionEnum<String>, String>, with viewController: UIViewController) {
            stubbedResults[result] = viewController
        }
        
        func questionViewController(for question: QuestionEnum<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(for result: QuizResult<QuestionEnum<String>, String>) -> UIViewController {
            return stubbedResults[result] ?? UIViewController()
        }
        
    }
    
}

extension QuizResult: Hashable {
    public func hash(into hasher: inout Hasher) {
        
    }
    
    public static func ==(lhs: QuizResult<Question, Answer>, rhs: QuizResult<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
