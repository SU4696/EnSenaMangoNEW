//
//  QuizLessonViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/23.
//

import UIKit
import FirebaseFirestore

class MyQuizTapGesture: UITapGestureRecognizer {
    var category = String()
}

public struct QuizLes {
    let name: String
}

class QuizLessonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func returnToLearn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var QuizView: UITableView!
    
     struct QuizLesson {
         let name: String
     }
     var QuizArray: [QuizLesson] = []
    
    let db = Firestore.firestore()
   
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuizArray.count
    }
    
    var QuizArrayDetail: [QuizLes] = []
    @objc func labelTapped(_ sender: MyQuizTapGesture) {
            //abrir un view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuizDetailLessonViewController") as! QuizDetailLessonViewController

                QuizArrayDetail = []
                db.collection("DICTIONARY").getDocuments { (snapshot, error) in
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
                                let newWord = QuizLes(name: (actualWord) as! String)
                            //Solo agregar unas para que sea aleatorio
                                self.QuizArrayDetail.append(newWord)
                        }}
                        break
                    }


                }
                vc.modalPresentationStyle = .fullScreen
                vc.word = sender.category
                vc.QuizArrayDetail = self.QuizArrayDetail
                    self.present(vc, animated: true)
           }
        }

       }

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = QuizView.dequeueReusableCell(withIdentifier: "cell") as! QuizTVC
            let target = QuizArray[indexPath.row]
            cell.catName.text = target.name
            //TODO: Asociar la acción del Tap (labelTapped) a un UIView en lugar de cell.textLabel
            //TODO: si no es posible, cambiar el width del label para que tome el mismo tamaño de la vista
                //Programatically Tapped Action
                let labelTap = MyQuizTapGesture(target: self, action: #selector(self.labelTapped(_:)))
                cell.catName.isUserInteractionEnabled = true
                cell.catName.addGestureRecognizer(labelTap)
                labelTap.category = target.name
                //Programatically Tapped Action

            cell.catView.layer.cornerRadius = cell.catView.frame.height/3
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
        
       

        // Do any additional setup after loading the view.
    }
    func getDatabaseRecords(){
      
       QuizArray = []
       db.collection("DICTIONARY").getDocuments { (snapshot, error) in
           if let error = error {
               print(error)
               return
           } else {
               for document in snapshot!.documents{
                   
                   let data = document.data()
                   let category = data["category"] as? String ?? ""
                   let newCategory = QuizLesson(name: category )
                   self.QuizArray.append(newCategory)
               }
               DispatchQueue.main.async {
                               self.QuizView.reloadData()
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
