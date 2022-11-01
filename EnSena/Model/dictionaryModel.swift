//
//  dictionaryModel.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//

import Foundation

class Dictionary {
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    static var dummyDicCategory = [
        Dictionary(name: "Alfabeto")
    ]
}

