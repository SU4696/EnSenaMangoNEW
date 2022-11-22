//
//  DictonaryDetailViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/31.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseStorage

class wordTapGesture: UITapGestureRecognizer {
    var wordname = String()
}

class DictonaryDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var palView: UITableView!
    var dicArrayDetail: [Dict] = []
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    var category: String = ""
    var wordname: String = ""
//    var elements = [DictionaryDetail(name: "")]
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 132
        }
    private var imageURL = URL(string:"")
    //let urlLabel.text = " \(imageURL?.absoluteString ?? "placeholder")"
    
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
    
    @objc func labelTapped(_ sender: wordTapGesture) {
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
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //obtener los elementos de la misma categoria
            //TODO: Incializar de manera correcta la varaible elments
//            let dictCount = DictionaryDetail.dummyPalCategory
//            elements = [DictionaryDetail(name: "")]
//            for item in dictCount {
//                if (item.category == category)
//                {
//                    elements.append(item)
//                }
//            }
            //TODO: Una vez inicializado de manera correcta se cambia return por return elements.count
            return dicArrayDetail.count
        }
    
    var wordPopUp: PopUpView!
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //TODO: Una vez inicializado de manera correcta se cambia elements por elements[indexPath.row]
            let target = dicArrayDetail[indexPath.row ]
            let cell = palView.dequeueReusableCell(withIdentifier: "dicCell", for: indexPath)
            cell.textLabel?.text = target.name
            //Programatically Tapped Action
            let labelTap = wordTapGesture(target: self, action: #selector(self.labelTapped(_:)))
            cell.textLabel!.isUserInteractionEnabled = true
            cell.textLabel!.addGestureRecognizer(labelTap)
            labelTap.wordname = target.name
            
            
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

            
            NotificationCenter.default.addObserver(forName: DicDetailCompseViewController.newPalDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in self?.palView.reloadData()}
            
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
/*
extension DictonaryDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dicCell", for: indexPath)
            return cell
        default:
            fatalError()
        }
        
    }
    
    
    
}
*/
