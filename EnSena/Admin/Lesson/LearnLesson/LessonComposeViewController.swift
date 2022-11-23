//
//  LearnComposeViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/13.
//

import UIKit
import FirebaseFirestore

class LessonComposeViewController: UIViewController {

    @IBOutlet weak var lesname: UITextField!
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        guard let name = lesname.text, name.count > 0 else{
            alert(message: "Teclea el nombre")
            return
        }
        //let newLes = Lesson(name: name)
        //Lesson.dummyLessonCategory.append(newLes)
        
        NotificationCenter.default.post(name: LearnComposeViewController.newLesDidInsert, object: nil)
        dismiss(animated: true, completion: nil)
        
        let db = Firestore.firestore()
        let categoryRef = db.collection("LESSON")

        let docUpdateData: [String: Any] = [
                "category": name,
                "learn":[]
        ]
        categoryRef.document("\(name)").setData(docUpdateData)
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
extension LearnComposeViewController {
    static let newLesDidInsert = Notification.Name(rawValue: "Nuevo Lección creado")
}

