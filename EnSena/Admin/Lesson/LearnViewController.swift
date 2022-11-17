//
//  LearnViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//

import UIKit

class MyLessonTapGesture: UITapGestureRecognizer {
    var category = String()
}


class LearnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var lessonName: UITableView!
   
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Lesson.dummyLessonCategory.count
    }
    
    @objc func labelTapped(_ sender: MyLessonTapGesture) {
            //abrir un view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LessonDetailViewController") as! LessonDetailViewController
  
        vc.modalPresentationStyle = .fullScreen
        vc.category = sender.category
            self.present(vc, animated: true)
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lessonName.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = Lesson.dummyLessonCategory[indexPath.row]
        cell.textLabel?.text = target.name
        //TODO: Asociar la acción del Tap (labelTapped) a un UIView en lugar de cell.textLabel
        //TODO: si no es posible, cambiar el width del label para que tome el mismo tamaño de la vista
            //Programatically Tapped Action
            let labelTap = MyLessonTapGesture(target: self, action: #selector(self.labelTapped(_:)))
            cell.textLabel!.isUserInteractionEnabled = true
            cell.textLabel!.addGestureRecognizer(labelTap)
            labelTap.category = target.name
            //Programatically Tapped Action
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
        
        NotificationCenter.default.addObserver(forName: LearnComposeViewController.newLesDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in self?.lessonName.reloadData()}

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
