//
//  dictionaryModel.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//

import Firebase

//
//class Dictionary {
//    var name: String
//    init(name: String){
//        self.name = name
//    }
//
//    static var dummyDicCategory = [
//        Dictionary(name: "Alfabeto"),
//    ]
//}
//struct Dictionary {
//    let name: String?
//}
//
//extension Dictionary {
//    static func build(from documents: [QueryDocumentSnapshot]) -> [Dictionary] {
//        var dictionaries = [Dictionary]()
//        for document in documents {
//            dictionaries.append(Dictionary(name: document["cateogry"] as? String ?? ""))
//        }
//        return dictionaries
//    }
//}
//
//class dictionaeyService {
//    let database = Firestore.firestore()
//
//    func get(collectionID: String, handler: @escaping ([Dictionary]) -> Void) {
//        database.collection("USER")
//            .addSnapshotListener { querySnapshot, err in
//                if let error = err {
//                    print(error)
//                    handler([])
//                } else {
//                    handler(Dictionary.build(from: querySnapshot?.documents ?? []))
//                }
//            }
//    }
//}
