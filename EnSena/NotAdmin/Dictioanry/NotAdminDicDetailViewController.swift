//
//  NotAdminDicDetailViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/17.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseStorage


class NotAdminDicDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var palView: UITableView!
    var dicArrayDetail: [Dict] = []
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var loadingData = false
    var category: String = ""
    var wordname: String = ""
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 132
        }
    private var imageURL = URL(string:"")
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
    
    @objc func labelTapped(_ sender: wordTapGesture) {
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicArrayDetail.count
    }
    
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
