//
//  lessonModel.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/10.
//

import Foundation

class Lesson {
    var name: String
    init(name: String){
        self.name = name
    }
    
    static var dummyLessonCategory = [
        Lesson(name: "Lección 1"),
        Lesson(name: "Lección 2")
    ]
}
