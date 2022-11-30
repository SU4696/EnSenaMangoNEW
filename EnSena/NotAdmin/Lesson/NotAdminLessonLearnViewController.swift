//
//  NotAdminLessonLearnViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/18.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseFirestore
import FirebaseStorage


class NotAdminLessonLearnViewController: UITabBarController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var lesView: UITableView!
    
    var LesArrayDetail: [LesLearn] = []
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var loadingData = false
    var word: String = ""
    var wordname: String = ""
    var check: String = ""
    private var imageURL = URL(string:"")
    
    let db = Firestore.firestore()
    
    
//    var = elements[indexPath.row]
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 342
        }
    
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return LesArrayDetail.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //TODO: Una vez inicializado de manera correcta se cambia elements por elements[indexPath.row]
            let target = LesArrayDetail[indexPath.row]
            let cell = lesView.dequeueReusableCell(withIdentifier: "lesCell") as! NALearnTVC
            cell.learnLabel.text = target.name
            func loadImage(){
                let storage = Storage.storage().reference(withPath: "dictionary/\(target.name).png")
                storage.downloadURL { [self] (url, error) in
                    if error != nil{
                        print ("Un error ocurrio al leer archivo \(storage) error = \(error?.localizedDescription)")
                        return
                    } else {
                        //abrir un view controller
                        cell.learnImage.sd_setImage(with: url!, placeholderImage: UIImage())
                    }
                    
                }
            }
            loadImage()

            return cell
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //nameView.reloadData()
            
           // print(#function)
        }
        var token: NSObjectProtocol?
        deinit {
            if let token = token {
                NotificationCenter.default.removeObserver(token)
                
            }
        }
    
   

   
        override func viewDidLoad() {
            super.viewDidLoad()
            lesView.estimatedRowHeight = 55
            lesView.rowHeight = UITableView.automaticDimension
            /*
            NotificationCenter.default.addObserver(forName: LessonDetailCompseViewController.newLesDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in self?.LesView.reloadData()}*/
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
