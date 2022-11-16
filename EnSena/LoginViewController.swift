//
//  ViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/09/26.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class LoginViewController: UIViewController {

   
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Auth.auth().languageCode="en"
        // Do any additional setup after loading the view.
      
        
    }

    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var pw: UITextField!
    
    func login(){
            Auth.auth().signIn(withEmail: id.text!, password: pw.text!) { (user,error) in
                if let error = error {
                    print(error.localizedDescription)
              }
                else{
                    print("OK")
                    let db = Firestore.firestore()
                    //var Information: [String:Any]?
                
                    db.collection("USER").order(by: "id").getDocuments { (querySnapshot, error) in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        
                    }
                    else {
                        //Information = querySnapshot!.documents.first?.data()
                        
                       
                        
                        //if tipo == 0 {
                          //  self.performSegue(withIdentifier: "AdminSegue", sender: nil)
                        for document in querySnapshot!.documents {
                            let data = document.data()
                        if self.id.text == data["correo"] as! String? &&
                            self.pw.text == data["password"] as! String? {
                            if data["type"] as! Int == 0{
                            self.performSegue(withIdentifier: "AdminSegue", sender: nil)
                            }                        }
                        }
                        }
                    }
                    
                }
                }
            }
    
    
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    
    
}

/*
 func login(){
         Auth.auth().signIn(withEmail: id.text!, password: pw.text!) { (user,error) in
             if let error = error {
                 print(error.localizedDescription)
           }
             else{
                 print("OK")
                 let db = Firestore.firestore()
                 var Information: [String:Any]?
             
                 db.collection("USER").order(by: "id").getDocuments { (querySnapshot, error) in
                 
                 if let error = error {
                     print(error.localizedDescription)
                     
                 }
                 else {
                     Information = querySnapshot!.documents.first?.data()
                     
                     var tipo: Int = Information!["type"] as! Int
                         if tipo == 0 {
                             self.performSegue(withIdentifier: "AdminSegue", sender: nil)
                         }
                     }
                 }}
             }
         }
 */
