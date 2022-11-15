//
//  LessonDetail.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/13.
//

import Foundation

class LessonAprender {
    var category: String
    var tipo: String
    var palabra: String
    var media: String
    init(palabra: String){
        self.palabra = palabra
        self.category = ""
        self.tipo = "Aprender"
        self.media = ""
    }
    init(palabra: String, category: String){
        self.palabra = palabra
        self.category = category
        self.tipo = "Aprender"
        self.media = ""
    }
    
    static var dummyLesCategory = [
        LessonAprender(palabra: "A"),
        LessonAprender(palabra: "vvv", category: "Lección 2")
//        DictionaryDetail(name: "B", category: "Alfabeto")
    ]
}
