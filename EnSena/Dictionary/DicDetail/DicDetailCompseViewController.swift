//
//  DicDetailCompseViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/31.
//

import UIKit

class DicDetailCompseViewController: UIViewController {
    
    @IBOutlet weak var palabra: UITextField!
    @IBOutlet weak var category: UITextField!

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let palabra = palabra.text, palabra.count > 0 else{
            alert(message: "Teclea palabra")
            return
        }
        guard let categoryname = category.text, categoryname.count > 0 else{
            alert(message: "Teclea Categoria respectando acento y mayuscula")
            return
        }
        //TODO: Cambiar category por variable dinámica
        let newPal = DictionaryDetail(name: palabra, category: categoryname)
        DictionaryDetail.dummyPalCategory.append(newPal)
        
        NotificationCenter.default.post(name: DicDetailCompseViewController.newPalDidInsert, object: nil)
        dismiss(animated: true, completion: nil)
        
        
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

extension DicDetailCompseViewController {
    static let newPalDidInsert = Notification.Name(rawValue: "Nueva Palabra creado")
}
