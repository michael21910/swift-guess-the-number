//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Tsuen Hsueh on 2021/10/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var systemMessage: UILabel!
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var remindMessage: UILabel!
    @IBOutlet weak var resultFace: UIImageView!
    
    // global variable
    var answer: Int?
    var guessCount: Int?
    
    func newGameStarts() {
        // reset answer number
        answer = Int.random(in: 1...10)
        // reset the count of the guess
        guessCount = 0
        print(answer!)
        // set input text field
        input.text = ""
        input.isUserInteractionEnabled = true
        // display the "confirm" button
        confirm.isHidden = false
        // display the remind message
        remindMessage.isHidden = false
        remindMessage.text = "5 tries left!"
        // hide the result emoji
        resultFace.isHidden = true
        // reset system message
        systemMessage.text = ""
        // hide the "new game" button
        newGameBtn.isHidden = true
    }
    
    func gameEnds_WIN() {
        // let user cannot type in the text field
        input.text = "You win!"
        input.isUserInteractionEnabled = false
        // hide the "confirm" button
        confirm.isHidden = true
        // hide the remind message
        remindMessage.isHidden = true
        // display the result emoji
        resultFace.isHidden = false
        resultFace.image = UIImage(named: "smile.jpg")
        // set system message
        systemMessage.text = "Correct! The answer is \(String(answer!))."
        // display the "new game" button
        newGameBtn.isHidden = false
    }
    
    func gameEnds_LOSE() {
        // let user cannot type in the text field
        input.text = "You lose!"
        input.isUserInteractionEnabled = false
        // hide the "confirm" button
        confirm.isHidden = true
        // hide the remind message
        remindMessage.isHidden = true
        // display the result emoji
        resultFace.isHidden = false
        resultFace.image = UIImage(named: "sad.jpg")
        // set system message
        systemMessage.text = "Fail the game! The answer is \(String(answer!))."
        // display the "new game" button
        newGameBtn.isHidden = false
    }
    
    // when the btn "confirm" get clicked
    @IBAction func clickConfirm(sender: UIButton) {
        // if the text field is not empty
        if(input.text != "") {
            // if the number is valid
            if let userInput = Int(input.text!) {
                if(userInput > 10 || userInput <= 0) {
                    let alertController = UIAlertController(title: "Wrong input!", message: "Please enter a number between 1 to 10", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
                else if(userInput > answer!) {
                    systemMessage.text = "Less than \(userInput)"
                    guessCount! += 1
                    // refresh the remind message
                    let countsLeft: Int = 5 - guessCount!
                    if(countsLeft == 1) {
                        remindMessage.text = "1 try left"
                    }
                    else {
                        remindMessage.text = "\(countsLeft) tries left"
                    }
                }
                else if(userInput < answer!) {
                    systemMessage.text = "Greater than \(userInput)"
                    guessCount! += 1
                    // refresh the remind message
                    let countsLeft: Int = 5 - guessCount!
                    if(countsLeft == 1) {
                        remindMessage.text = "1 try left"
                    }
                    else {
                        remindMessage.text = "\(countsLeft) tries left"
                    }
                }
                else if(userInput == answer!) {
                    gameEnds_WIN()
                }
            }
            // if the number is invalid
            else {
                let alertController = UIAlertController(title: "Wrong input!", message: "This is an invalid number", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
            // if the user guesses the number 5 times
            // the game ends, user loses
            if(guessCount == 5) {
                gameEnds_LOSE()
            }
        }
        // if the text field is empty
        else {
            let alertController = UIAlertController(title: "Wrong input!", message: "Please input a number into the text field", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // when the btn "new game" get clicked
    @IBAction func clickNewGame() {
        newGameStarts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newGameStarts()
    }
}
