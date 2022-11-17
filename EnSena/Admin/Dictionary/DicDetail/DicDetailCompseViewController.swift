//
//  DicDetailCompseViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/31.
//

import UIKit
import Firebase
import FirebaseStorage

/*
 [
    {
        "category": "ABCD",
        "words": [
            {
                "word": "A",
                "media": "http://"
            }
        ]
    }
 ]
 */

class DicDetailCompseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var palabra: UITextField!
    @IBOutlet weak var category: UITextField!
    var imageData: Data?
    @IBOutlet weak var label: UILabel!
    
    private let storage = Storage.storage().reference()
    
    @IBAction func tabImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        guard let imageData = image.pngData() else{
            return
        }
        self.imageData = imageData
        /*
         /Desktop/file,png
         */
//        storage.child("images/file.png").putData(imageData, metadata: nil, completion: { _, error in
//            guard error == nil else{
//                print("Failed to uploead")
//                return
//            }
//            self.storage.child("images/file.png").downloadURL(completion: {url, error in
//                guard let url = url, error == nil else {
//                    return
//                }
//                let urlString=url.absoluteString
//                print("Download URL: \(urlString)")
//                UserDefaults.standard.set(urlString, forKey: "url")
//
//            })
//        })
        //upload image data
        //get download url
        //sabe download url to userDefault
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }


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
        
        
        let db = Firestore.firestore()
        //CODIGO PARA CREAT CATEGORIAS
//        let docData: [String: Any] = [
//            "categories": [[
//                "category": "Alfabeto",
//                "words": [[
//                    "media": "a.png",
//                    "word": "A",
//                ],[
//                    "media": "b.png",
//                    "word": "B",
//                ]]
//                ],
//                           [
//                                "category": "Herramientas",
//                                "words": [[
//                                    "media": "Martillo.png",
//                                    "word": "Martillo",
//                                ],[
//                                    "media": "Tonrillo.png",
//                                    "word": "Tonrillo",
//                                ]]
//                           ]
//                          ]
//        ]
//        db.collection("DICTIONARY").document("dictionary").setData(docData) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }
        
        //CODIGO PARA ACTUALIZAR CATEGORIAS
        let alfabetoRef = db.collection("DICTIONARY").document("dictionary")

        
        let docUpdateData: [String: Any] = [
                "category": categoryname,
                "words": [[
                    "media": "\(palabra).png",
                    "word": palabra,
                ]]
        ]
        // Atomically add a new region to the "regions" array field.
        alfabetoRef.updateData([
            "categories": FieldValue.arrayUnion([docUpdateData])
        ])
        
        
        storage.child("dictionary/\(palabra).png").putData(imageData!, metadata: nil, completion: { _, error in
           guard error == nil else{
               print("Failed to uploead")
               return
           }
           self.storage.child("dictionary/\(palabra).png").downloadURL(completion: {url, error in
               guard let url = url, error == nil else {
                   return
               }
               let urlString=url.absoluteString
               print("Download URL: \(urlString)")
               UserDefaults.standard.set(urlString, forKey: "url")

           })
       })
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
              let url = URL(string:urlString) else{
            return
        }
        
        label.text=urlString
        
        /*let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else{
                return
            }
            DispatchQueue.main.async{
                let image = UIImage(data: data)
            }
        })*/

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
