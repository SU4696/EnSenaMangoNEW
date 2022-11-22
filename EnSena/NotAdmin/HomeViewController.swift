//
//  HomeViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//

import UIKit
import FirebaseFirestore
import SDWebImage
import Firebase
import FirebaseStorage

public class wordsTapGesture: UITapGestureRecognizer {
    var wordname = String()
}
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var wordView: UITableView!
    private var imageURL = URL(string:"")
    
    var wordname: String = ""
    
    struct words {
        let name: String
    }
    
    var homeArray: [words] = []
    let db = Firestore.firestore()
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeArray.count
    }
    func loadImage(){
        let storage = Storage.storage().reference(withPath: "dictionary/\(wordname).png")
        storage.downloadURL { (url, error) in
            if error != nil{
                print ("Un error ocurrio al leer archivo \(storage) error = \(error?.localizedDescription)")
                return
            } else {
                
            }
            self.imageURL = url!
        }
    }
    var wordPopUp: PopUpView!
    @objc func labelTapped(_ sender: wordsTapGesture) {
            //abrir un view controller
        self.wordPopUp = PopUpView(frame: self.view.frame)
        self.wordPopUp.close.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        self.view.addSubview(wordPopUp)
        self.wordname=sender.wordname

        self.wordPopUp.wordLabel.text = wordname
        loadImage()
        self.wordPopUp.wordImage.sd_setImage(with: imageURL, placeholderImage: UIImage())
        self.wordPopUp.urlLabel.text = " \(imageURL?.absoluteString ?? "placeholder")"

        }
    
    @objc func closeTapped(){
        self.wordPopUp.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = homeArray[indexPath.row ]
        let cell = wordView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath)
        cell.textLabel?.text = target.name
        //Programatically Tapped Action
        let labelTap = wordsTapGesture(target: self, action: #selector(self.labelTapped(_:)))
        cell.textLabel!.isUserInteractionEnabled = true
        cell.textLabel!.addGestureRecognizer(labelTap)
        labelTap.wordname = target.name
        
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatabaseRecords()

        // Do any additional setup after loading the view.
    }
    func getDatabaseRecords(){
      
        homeArray = []
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
                    let newCategory = words(name: category )
                    self.homeArray.append(newCategory)
                }
                DispatchQueue.main.async {
                                self.wordView.reloadData()
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
