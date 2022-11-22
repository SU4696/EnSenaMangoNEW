//
//  NotAdminDictionaryViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/17.
//
import UIKit
import FirebaseFirestore

class TapGesture: UITapGestureRecognizer {
    var category = String()
}


class NotAdminDictionaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nameView: UITableView!
    struct Dictionary {
        let name: String
    }
    var dicArray: [Dictionary] = []
        
    let db = Firestore.firestore()
   
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicArray.count
    }
    var dicArrayDetail: [Dict] = []
    
    @objc func labelTapped(_ sender: TapGesture) {
            //abrir un view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NotAdminDicDetailViewController") as! NotAdminDicDetailViewController

        
               dicArrayDetail = []
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
                                        let newWord = Dict(name: (actualWord) as! String)
                                    //Solo agregar unas para que sea aleatorio
                                        self.dicArrayDetail.append(newWord)
                                }}
                                break
                            }
                            
                           
                        }
                        vc.modalPresentationStyle = .fullScreen
                        vc.category = sender.category
                        vc.dicArrayDetail = self.dicArrayDetail
                            self.present(vc, animated: true)
                   }
                }
         
               }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nameView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = dicArray[indexPath.row]
        cell.textLabel?.text = target.name
        //TODO: Asociar la acción del Tap (labelTapped) a un UIView en lugar de cell.textLabel
        //TODO: si no es posible, cambiar el width del label para que tome el mismo tamaño de la vista
            //Programatically Tapped Action
            let labelTap = TapGesture(target: self, action: #selector(self.labelTapped(_:)))
            cell.textLabel!.isUserInteractionEnabled = true
            cell.textLabel!.addGestureRecognizer(labelTap)
            labelTap.category = target.name
            //Programatically Tapped Action
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getDatabaseRecords()
        
        // Do any additional setup after loading the view.
    }
     func getDatabaseRecords(){
       
         dicArray = []
         db.collection("DICTIONARY").getDocuments { (snapshot, error) in
             if let error = error {
                 print(error)
                 return
             } else {
                 for document in snapshot!.documents{
 //                    let data = document.data()
 //                   let newEntry = Dictionary(
 //                       name: data["category"] as! String)
 //                   self.dicArray.append(newEntry)
                 
                     let data = document.data()
                     let category = data["category"] as? String ?? ""
                     let newCategory = Dictionary(name: category )
                     self.dicArray.append(newCategory)
                 }
                 DispatchQueue.main.async {
                                 self.nameView.reloadData()
                             }
            }
          
         }

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
