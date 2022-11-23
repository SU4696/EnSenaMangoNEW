//
//  LearnComposeViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/23.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore


class LearnComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var palabra: UITextField!
    @IBOutlet weak var category: UITextField!
    var imageData: Data?
    @IBOutlet weak var label: UILabel!
    let db = Firestore.firestore()
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
       
        NotificationCenter.default.post(name: DicDetailCompseViewController.newPalDidInsert, object: nil)
        dismiss(animated: true, completion: nil)
        
        

          let db = Firestore.firestore()
           db.collection("LESSON").getDocuments { (snapshot, error) in
               if let error = error {
                   print(error)
                   return
               } else {
                   for document in snapshot!.documents{
                       let data = document.data()
                       let category = data["category"] as? String ?? ""
                      
                       if category == categoryname{
                           let wordRef = db.collection("LESSON").document("\(categoryname)")
                          
                           let docUpdateData: [String: Any] =
                                    [
                                      "word": palabra,
                                       "media": "\(palabra).png"
                                   ]
                           
                           // Atomically add a new region to the "regions" array field.
                           wordRef.updateData([
                               "learn": FieldValue.arrayUnion([docUpdateData])
                           ])
                       }
                       
                   }
                   }
              }
           
          
          
          
          
          storage.child("lesson/\(palabra)").putData(imageData!, metadata: nil, completion: { _, error in
             guard error == nil else{
                 print("Failed to uploead")
                 return
             }
             self.storage.child("lesson/\(palabra).png").downloadURL(completion: {url, error in
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
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
    extension DicDetailCompseViewController {
        static let newLesDidInsert = Notification.Name(rawValue: "Nueva Palabra creado")
    }
