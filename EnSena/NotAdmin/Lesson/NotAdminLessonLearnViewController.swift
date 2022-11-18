//
//  NotAdminLessonLearnViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/18.
//

import UIKit
import Firebase
import FirebaseStorage

class NotAdminLessonLearnViewController: UITabBarController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var LearnView: UITableView!
    var LesArrayLearn: [LesLearn] = []
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var category: String = ""
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LesArrayLearn.count
    }
    
//    var elements = [LessonAprender(palabra: "")]
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 132
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = LesArrayLearn[indexPath.row ]
        let cell = LearnView.dequeueReusableCell(withIdentifier: "learnCell", for: indexPath)
        cell.textLabel?.text = target.name
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
