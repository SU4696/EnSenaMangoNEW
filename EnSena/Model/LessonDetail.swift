//
//  LessonDetail.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/13.
//

import Foundation

class LessonDetail {
    var category: String
    var name: String
    init(name: String){
        self.name = name
        self.category = "Alfabeto"
    }
    init(name: String, category: String){
        self.name = name
        self.category = category
    }
    
    static var dummyLesCategory = [
        LessonDetail(name: "A"),
        LessonDetail(name: "Tornillo", category: "Herramientas")
//        DictionaryDetail(name: "B", category: "Alfabeto")
    ]
}
