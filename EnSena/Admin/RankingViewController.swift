//
//  RankingViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/17.
//

import UIKit
import Firebase
import FirebaseFirestore


public struct Rank {
    let name: String
    let score: String
}

class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var RankArray: [Rank] = []
    @IBOutlet weak var RankView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RankArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    let db = Firestore.firestore()
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RankView.dequeueReusableCell(withIdentifier: "cell") as! RankTableViewCell
        let target = RankArray[indexPath.row]
        cell.nameLabel.text = target.name
        cell.scoreLabel.text = target.score
        //TODO: Asociar la acción del Tap (labelTapped) a un UIView en lugar de cell.textLabel
        //TODO: si no es posible, cambiar el width del label para que tome el mismo tamaño de la vista
            //Programatically Tapped Action
           
            
            //Programatically Tapped Action
        
       
        return cell
    }
    

    
//    citiesRef
//        .order(by: "state")
//        .order(by: "population", descending: true)
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatabaseRecords()

        // Do any additional setup after loading the view.
    }
    
    func getDatabaseRecords(){
      
       RankArray = []
        db.collection("USER").order(by: "score", descending: true).getDocuments { (snapshot, error) in
           if let error = error {
               print(error)
               return
           } else {
               for document in snapshot!.documents{
                 
                   let data = document.data()
                   let nameR = data["name"] as? String ?? ""
                   let scoreR = data["score"] as? String ?? ""
                   let newRank = Rank(name: nameR, score: scoreR )
                   self.RankArray.append(newRank)
               }
               DispatchQueue.main.async {
                               self.RankView.reloadData()
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
