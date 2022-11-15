//
//  ViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/09/26.
//

import UIKit
import Firebase
import SwiftUI

class LoginViewController: UIViewController {

    let db = Firestore.firestore()
    
    var opc : Int?
    var iduser : QueryDocumentSnapshot?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
    }

    @IBOutlet weak var idEmail: UITextField!
    
    @IBOutlet weak var pw: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        logInAdmin()
    }
    func logInAdmin(){
            
            db.collection("Administrador").getDocuments { querySnapshot, error in
                
                if let error = error {
                    self.opc = -1
                    print(error.localizedDescription)
                    
                }
                else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if self.idEmail.text == data["id"] as! String? &&
                            self.pw.text == data["pw"] as! String?{
                            self.iduser = document
                            self.opc = 2
                            self.performSegue(withIdentifier: "logInAdmin", sender: nil)
                        }
                        /*else{
                            self.tfEmail.text = ""
                            self.tfPassword.text = ""
                            
                            let alerta = UIAlertController(title: "Error", message: "El usuario o contraseña son incorrectos", preferredStyle: .alert)
                            
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                            alerta.addAction(action)
                            self.present(alerta, animated: true, completion: nil)
                        }*/
                    }
                }
            }
        }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "logInAdmin"{
                 let vc = segue.destination as? AdminTabBarController
  
            }
    
    }
}

