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
    var loadingData = false
    var wordname: String = ""
    
    struct words {
        let name: String
    }
    
    var list: [String] = []
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
        storage.downloadURL { [self] (url, error) in
            if error != nil{
                print ("Un error ocurrio al leer archivo \(storage) error = \(error?.localizedDescription)")
                return
            } else {
                //abrir un view controller
            self.wordPopUp = PopUpView(frame: self.view.frame)
            self.wordPopUp.close.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            self.view.addSubview(wordPopUp)

            self.wordPopUp.wordLabel.text = wordname
                self.wordPopUp.wordImage.sd_setImage(with: url!, placeholderImage: UIImage())
                self.wordPopUp.urlLabel.text = " \(url!.absoluteString ?? "placeholder")"
            }
        }
    }
    
    var wordPopUp: PopUpView!
    @objc func labelTapped(_ sender: wordsTapGesture) {
        print("VALOR: \(loadingData)")
        if !loadingData {
            loadingData = true
            self.wordname=sender.wordname
            loadImage()
        }
        }
    
    @objc func closeTapped(){
        self.wordPopUp.removeFromSuperview()
        loadingData = false
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
                    //let id = document.documentID

                    let wordsa = data["words"] as? Array<Any>
                    if(wordsa!.count != 0){
                    for wordIndex in 0...wordsa!.count-1 {
                            let word = wordsa![wordIndex] as? [String: Any]
                            let actualWord = word!["word"] as! String
                        self.list.append(actualWord)
                        //Solo agregar unas para que sea aleatorio
                            
                    }}
                }
                for _ in 1...3  {
                let randomword = self.list.randomElement()!
                    if let index = self.list.firstIndex(of: "\(randomword)") {
                        self.list.remove(at: index)
                    }
                let newCategory = words(name: randomword )
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
