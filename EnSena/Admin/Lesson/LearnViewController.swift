//
//  LearnViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//

import UIKit
import FirebaseFirestore

class MyLessonTapGesture: UITapGestureRecognizer {
    var category = String()
}
public struct Les {
    let name: String
}

class LearnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lessonName: UITableView!
   
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    struct Lesson {
        let name: String
    }
    var LesArray: [Lesson] = []
        
    let db = Firestore.firestore()
   
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LesArray.count
    }
    var LesArrayDetail: [Les] = []
    @objc func labelTapped(_ sender: MyLessonTapGesture) {
            //abrir un view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LessonDetailViewController") as! LessonDetailViewController
        
                LesArrayDetail = []
                db.collection("LESSON").getDocuments { (snapshot, error) in
                    if let error = error {
                        print(error)
                        return
                    } else {
                for document in snapshot!.documents{
                    
                    let data = document.data()
                    let category = data["category"] as? String ?? ""
                   
                    if category == sender.category
                    {
                        let words = data["words"] as? Array<Any>
                        if(words!.count != 0){
                        for wordIndex in 0...words!.count-1 {
                                let word = words![wordIndex] as? [String: Any]
                                let actualWord = word!["word"]
                                let newWord = Les(name: (actualWord) as! String)
                            //Solo agregar unas para que sea aleatorio
                                self.LesArrayDetail.append(newWord)
                        }}
                        break
                    }
                    
                   
                }
                vc.modalPresentationStyle = .fullScreen
                vc.category = sender.category
                vc.LesArrayDetail = self.LesArrayDetail
                    self.present(vc, animated: true)
           }
        }
 
       }
   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lessonName.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = LesArray[indexPath.row]
        cell.textLabel?.text = target.name
        //TODO: Asociar la acción del Tap (labelTapped) a un UIView en lugar de cell.textLabel
        //TODO: si no es posible, cambiar el width del label para que tome el mismo tamaño de la vista
            //Programatically Tapped Action
            let labelTap = MyLessonTapGesture(target: self, action: #selector(self.labelTapped(_:)))
            cell.textLabel!.isUserInteractionEnabled = true
            cell.textLabel!.addGestureRecognizer(labelTap)
            labelTap.category = target.name
            //Programatically Tapped Action
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //nameView.reloadData()
        
       // print(#function)
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        getDatabaseRecords()
        
        NotificationCenter.default.addObserver(forName: LearnComposeViewController.newLesDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in self?.lessonName.reloadData()}

        // Do any additional setup after loading the view.
    }
    func getDatabaseRecords(){
      
       LesArray = []
       db.collection("LESSON").getDocuments { (snapshot, error) in
           if let error = error {
               print(error)
               return
           } else {
               for document in snapshot!.documents{
                   
                   let data = document.data()
                   let category = data["category"] as? String ?? ""
                   let newCategory = Lesson(name: category )
                   self.LesArray.append(newCategory)
               }
               DispatchQueue.main.async {
                               self.lessonName.reloadData()
                           }
       }
       }}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
