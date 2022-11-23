//
//  LessonDetailViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/13.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseStorage

class LessonDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var LesView: UITableView!
    
    var LesArrayDetail: [Les] = []
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var loadingData = false
    var category: String = ""
    var wordname: String = ""
    
//    var elements = [LessonAprender(palabra: "")]
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 132
        }
    private var imageURL = URL(string:"")
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return LesArrayDetail.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //TODO: Una vez inicializado de manera correcta se cambia elements por elements[indexPath.row]
            let target = LesArrayDetail[indexPath.row ]
            let cell = LesView.dequeueReusableCell(withIdentifier: "lesCell") as! LearnTVC
            cell.learnLabel.text = target.name
          //  cell.learnImage.image = UIImage(media: target.name)
            
            
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
