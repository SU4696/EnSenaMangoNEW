//
//  UIViewController+Alert.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//

import UIKit

extension UIViewController{
    func alert(title: String = "Alerta", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
