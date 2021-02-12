//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by Clay Suttner on 2/11/21.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionEnumTest: XCTestCase {
    
    func test_hashValue_singleAnswer_returnsTypeHash() {
        let type = "a string"
        
        let sut = QuestionEnum.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash() {
        let type = "a string"
        
        let sut = QuestionEnum.multipleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_equal_isEqual() {
        XCTAssertEqual(QuestionEnum.singleAnswer("a string"), QuestionEnum.singleAnswer("a string"))
        XCTAssertEqual(QuestionEnum.multipleAnswer("a string"), QuestionEnum.multipleAnswer("a string"))
    }
    
    func test_notEqual_isNotEqual() {
        XCTAssertNotEqual(QuestionEnum.singleAnswer("a string"), QuestionEnum.singleAnswer("different string"))
        XCTAssertNotEqual(QuestionEnum.multipleAnswer("a string"), QuestionEnum.multipleAnswer("different string"))
        XCTAssertNotEqual(QuestionEnum.singleAnswer("a string"), QuestionEnum.multipleAnswer("a String"))
        XCTAssertNotEqual(QuestionEnum.singleAnswer("a string"), QuestionEnum.multipleAnswer("different string"))
    }
    
}
