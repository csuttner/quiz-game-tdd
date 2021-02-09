//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Clay Suttner on 2/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = ResultsViewController(summary: "You got 1/2 correct", answers: [
            PresentableAnswer(question: "Question?? Question?? Question?? Question?? Question?? Question?? Question?? Question?? Question?? Question??", answer: "Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! ", wrongAnswer: nil),
            PresentableAnswer(question: "Another question??? Another question??? Another question??? Another question??? Another question??? Another question??? ", answer: "Hell yeah! Hell yeah! Hell yeah! Hell yeah!Hell yeah! Hell yeah!", wrongAnswer: "Hell no Hell no Hell no Hell no Hell no Hell no Hell no Hell no"),
            
        ])
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

