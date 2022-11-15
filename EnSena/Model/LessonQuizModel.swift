//
//  LessonQuiz.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/14.
//

import Foundation
class LessonQuiz {
    var category: String
    var tipo: String
    var repuesta: String
    var media: String
    init(repuesta: String){
        self.repuesta = repuesta
        self.category = ""
        self.tipo = "Quiz"
        self.media = ""
    }
    init(repuesta: String, category: String){
        self.repuesta = repuesta
        self.category = category
        self.tipo = "Quiz"
        self.media = ""
    }
    
    static var dummyLesCategory = [
        LessonQuiz(repuesta: "A"),
        LessonQuiz(repuesta: "vvv", category: "Lección 2")
//        DictionaryDetail(name: "B", category: "Alfabeto")
    ]
}
