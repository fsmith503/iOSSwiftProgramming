//
//  ViewController.swift
//  Quiz
//
//  Created by franklin smith on 12/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionlabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var showAnswerButton: UIButton!
    
    
    let questions: [String] = [
    "What is 7+7?",
    "What is the capital of California",
    "What is wine made from?"
    ]
    
    let answers: [String] = [
    "14",
    "Sacramento",
    "Grapes"
    ]
    
    var currentQuestionIndex: Int = 0
    var showAnswerCount: Int = 0
    @IBAction func showNextQuestion(_ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count{
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        questionlabel.text = question
        answerLabel.text = "??? IDK"
    }
    
    @IBAction func showAnswer(_ sender: UIButton){
        showAnswerCount += 1
        if showAnswerCount % 2 == 0{
            showAnswerButton.setTitle("Hide Answer", for: .normal)
            let answer: String = answers[currentQuestionIndex]
            answerLabel.text = answer
            //answerLabel.text = "??? IDK"
            
        }
        else {
            showAnswerButton.setTitle("Show Answer", for: .normal)
            answerLabel.text = "??? IDK"
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        questionlabel.text = questions[currentQuestionIndex]
        // Do any additional setup after loading the view.
    }


}

