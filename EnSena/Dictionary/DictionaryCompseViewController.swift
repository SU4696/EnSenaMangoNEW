//
//  DictionaryCompseViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//

import UIKit
import Firebase
import FirebaseStorage


class DictionaryCompseViewController: UIViewController{

    @IBOutlet weak var catname: UITextField!
    var imageData: Data?
    private let storage = Storage.storage().reference()
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        guard let name = catname.text, name.count > 0 else{
            alert(message: "Teclea el nombre")
            return
        }
//        let newDic = Dictionary(name: name)
//        Dictionary.dummyDicCategory.append(newDic)
//
        NotificationCenter.default.post(name: DictionaryCompseViewController.newDicDidInsert, object: nil)
        dismiss(animated: true, completion: nil)

        let db = Firestore.firestore()
        let alfabetoRef = db.collection("DICTIONARY").document("dictionary")

        let docUpdateData: [String: Any] = [
                "category": name,
                "words": [[
                    "media": "",
                    "word": "",
                ]]
        ]
        // Atomically add a new region to the "regions" array field.
        alfabetoRef.updateData([
            "categories": FieldValue.arrayUnion([docUpdateData])
        ])
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DictionaryCompseViewController {
    static let newDicDidInsert = Notification.Name(rawValue: "Nuevo Diccionario creado")
}
