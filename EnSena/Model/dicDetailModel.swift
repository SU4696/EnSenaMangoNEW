//
//  dicDetailModel.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/31.
//

import Foundation

class DictionaryDetail {
    var category: String
    var name: String
    var image: String
    init(name: String){
        self.name = name
        self.category = "Alfabeto"
        self.image = ""
    }
    init(name: String, category: String){
        self.name = name
        self.category = category
        self.image = ""
    }
    
    static var dummyPalCategory = [
        DictionaryDetail(name: "A"),
        DictionaryDetail(name: "Tornillo", category: "Herramientas")
//        DictionaryDetail(name: "B", category: "Alfabeto")
    ]
}
