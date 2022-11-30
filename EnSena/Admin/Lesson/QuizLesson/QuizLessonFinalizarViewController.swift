//
//  QuizLessonFinalizarViewController.swift
//  EnSena
//
//  Created by Mau on 29/11/22.
//

import UIKit

class QuizLessonFinalizarViewController: UIViewController {

    @IBOutlet weak var rightAnswerNumber: UILabel!
    
    @IBOutlet weak var pointsAmount: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightAnswerNumber.text = "\(rightAnswers)"
        switch rightAnswers{
        case 0:
            pointsAmount.text = "0"
        case 1:
            pointsAmount.text = "2"
        case 2:
            pointsAmount.text = "4"
        case 3:
            pointsAmount.text = "6"
        case 4:
            pointsAmount.text = "8"
        case 5:
            pointsAmount.text = "10"
        default:
            pointsAmount.text = "0"
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func exitButtonPress(_ sender: Any) {
        rightAnswers = 0
        self.view.window?.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
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
