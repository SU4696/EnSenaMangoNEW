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

public var rightAnswers: Int = 0




class QuizDetailLessonViewController: UIViewController {
    
    var QuizArrayDetail: [QuizLes] = []
    
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var answerSelected: UILabel!
    
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
    var lockedQuestions: [String] = []
    var questionNumber: Int = 1

    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        if (questionNumber == 5) {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func optionOnePress(_ sender: Any) {
        
//        checkAnswer(answerCheck: word, buttonTitle: "\(optionOne.titleLabel)")
        answerSelected.text = optionOne.titleLabel?.text

    }
    
    @IBAction func optionTwoPress(_ sender: Any) {
        answerSelected.text = optionTwo.titleLabel?.text

        }
    
    
    @IBAction func optionThreePress(_ sender: Any) {
        answerSelected.text = optionThree.titleLabel?.text

    }
    
    @IBAction func optionFourPress(_ sender: Any) {
        answerSelected.text = optionFour.titleLabel?.text

    }
    
    @IBAction func exitPress(_ sender: Any) {
        rightAnswers = 0
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func nextPress(_ sender: Any) {
        if (answerSelected.text == word){
            rightAnswers += 1
    }
        
//        if (questionNumber == 5){
//            dismiss(animated: true, completion: nil)
//        }
        if (questionNumber >= 5) {
//            pushQuizViewController()
//            questionNumber = 69
//            nextButton.addTarget(self, action: #selector(pushQuizViewController), for: .touchUpInside)
            pushQuizViewController()
        } else {
            questionNumber += 1
            questionNumberLabel.text = "\(questionNumber)"
            answerSelected.text = ""
            nextQuestion()
        
//            respuestaCheck.text = "\(rightAnswers)"
        }

    }
    
    func nextQuestion(){
        var answer = QuizArrayDetail.randomElement()!.name
        
        while (lockedQuestions.contains(answer)) {
            answer = QuizArrayDetail.randomElement()!.name
        }
        lockedQuestions.append(answer)
        
        word = answer
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
            var storage = Storage.storage().reference(withPath: "dictionary/\(answer).png")
            storage.downloadURL { [self] (url, error) in
                if error != nil{
                    storage = Storage.storage().reference(withPath: "dictionary/\(answer).gif")
                                      storage.downloadURL { [self] (url, error) in
                                          if error != nil{

                                              print ("Un error ocurrio al leer archivo \(storage) error = \(error?.localizedDescription)")
                                             return
                                          } else {
                                              //abrir un view controller
                                              quizImage.sd_setImage(with: url!, placeholderImage: UIImage())
                                          }
                                      }
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
        lockedWords.append(fakeAnswer)
        return fakeAnswer
    }
    
    func checkAnswer (answerCheck: String, buttonTitle: String) -> Bool {
        if (buttonTitle == answerCheck) {
            return true
        } else {
            return false
        }
    }
    
    @objc func pushQuizViewController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = sb.instantiateViewController(withIdentifier: "QuizLessonFinalizarViewController") as! QuizLessonFinalizarViewController
        self.present(destinationVC, animated: true)
        
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
