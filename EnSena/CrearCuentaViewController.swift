//
//  CrearCuentaViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/14.
//

import UIKit
import FirebaseDatabase

class CrearCuentaViewController: UIViewController {

    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var pw: UITextField!
    
    @IBOutlet weak var edad: UITextField!
    
    @IBOutlet weak var codigo: UITextField!

    
    @IBAction func CreatButton(_ sender: UIButton) {
        let componenteDB =  Database.database().reference()
        componenteDB.childByAutoId().setValue(["usernombre": nombre.text, "userid": id.text, "userpw": pw.text, "useredad": edad.text,  "usercodigo": codigo.text])
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
