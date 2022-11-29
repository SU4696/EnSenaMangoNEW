//
//  QuizDetailLessonViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/23.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseFirestore
import FirebaseStorage

public struct WordQuiz {
    let name: String
}

class QuizDetailLessonViewController: UIViewController {
    
    var QuizArrayDetail: [QuizLes] = []
    
    
    @IBOutlet weak var quizImage: UIImageView!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var optionFour: UIButton!
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    var loadingData = false
    var word: String = ""
    var wordname: String = ""
    private var imageURL = URL(string:"")
    var lockedWords: [String] = []
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
    }
    
    @IBAction func optionOnePress(_ sender: Any) {
        
    }
    
    @IBAction func optionTwoPress(_ sender: Any) {
        
    }
    
    @IBAction func optionThreePress(_ sender: Any) {
        
    }
    
    @IBAction func optionFourPress(_ sender: Any) {
        
    }
    
    @IBAction func exitPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextPress(_ sender: Any) {
        nextQuestion()
        
    }
    
    func nextQuestion(){
        let answer = QuizArrayDetail.randomElement()!.name
        var n = Int.random(in: 1...4)
        switch n {
        case 1:
            optionOne.setTitle("\(answer)", for: [])
            lockedWords.append(answer)
            optionTwo.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionThree.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionFour.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            lockedWords.removeAll()
        case 2:
            optionTwo.setTitle("\(answer)", for: [])
            lockedWords.append(answer)
            optionOne.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionThree.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionFour.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            lockedWords.removeAll()
        case 3:
            optionThree.setTitle("\(answer)", for: [])
            lockedWords.append(answer)
            optionTwo.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionOne.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionFour.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            lockedWords.removeAll()
        case 4:
            optionFour.setTitle("\(answer)", for: [])
            lockedWords.append(answer)
            optionTwo.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionThree.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionOne.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            lockedWords.removeAll()
        default:
            optionThree.setTitle("\(answer)", for: [])
            lockedWords.append(answer)
            optionTwo.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionOne.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            optionFour.setTitle("\(setNonAnswer(answerCheck: answer))", for: [])
            lockedWords.removeAll()
        }

        
//        optionThree.setTitle("\(answer)", for: [])
//        optionFour.setTitle("\(n)", for: [])
//        let notAnswer = setNonAnswer(answerCheck: answer)
//        optionOne.setTitle("\(notAnswer)", for: [])
        
        func loadImage(){
            let storage = Storage.storage().reference(withPath: "dictionary/\(answer).png")
            storage.downloadURL { [self] (url, error) in
                if error != nil{
                    print ("Un error ocurrio al leer archivo \(storage) error = \(error?.localizedDescription)")
                    return
                } else {
                    //abrir un view controller
                    quizImage.sd_setImage(with: url!, placeholderImage: UIImage())
                }
                

        // Do any additional setup after loading the view.
            }
        }
        loadImage()
    }
    
    
    func setNonAnswer (answerCheck: String) -> String {
        var fakeAnswer = QuizArrayDetail.randomElement()!.name
        while (lockedWords.contains(fakeAnswer)) {
            
            fakeAnswer = QuizArrayDetail.randomElement()!.name
        }
//            for lWord in lockedWords where lWord == fakeAnswer{
//                fakeAnswer = QuizArrayDetail.randomElement()!.name
//            }
            
        
        lockedWords.append(fakeAnswer)
        return fakeAnswer
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
