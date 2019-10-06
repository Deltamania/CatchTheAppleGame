//
//  ViewController.swift
//  CatchGame
//
//  Created by Murat Han on 6.10.2019.
//  Copyright © 2019 Murat Han. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var appleArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Viwes def
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var apple1: UIImageView!
    @IBOutlet weak var apple2: UIImageView!
    @IBOutlet weak var apple3: UIImageView!
    @IBOutlet weak var apple4: UIImageView!
    @IBOutlet weak var apple5: UIImageView!
    @IBOutlet weak var apple6: UIImageView!
    @IBOutlet weak var apple7: UIImageView!
    @IBOutlet weak var apple8: UIImageView!
    @IBOutlet weak var apple9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        //highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        
        
        apple1.isUserInteractionEnabled = true
        apple2.isUserInteractionEnabled = true
        apple3.isUserInteractionEnabled = true
        apple4.isUserInteractionEnabled = true
        apple5.isUserInteractionEnabled = true
        apple6.isUserInteractionEnabled = true
        apple7.isUserInteractionEnabled = true
        apple8.isUserInteractionEnabled = true
        apple9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        apple1.addGestureRecognizer(recognizer1)
        apple2.addGestureRecognizer(recognizer2)
        apple3.addGestureRecognizer(recognizer3)
        apple4.addGestureRecognizer(recognizer4)
        apple5.addGestureRecognizer(recognizer5)
        apple6.addGestureRecognizer(recognizer6)
        apple7.addGestureRecognizer(recognizer7)
        apple8.addGestureRecognizer(recognizer8)
        apple9.addGestureRecognizer(recognizer9)
        
        appleArray = [apple1,apple2,apple3,apple4,apple5,apple6,apple7,apple8,apple9]
        
        //Timers
        
        counter = 10
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(hideApple), userInfo: nil, repeats: true)
        
        hideApple()
        
        
        
    }
    
    @objc func hideApple(){
        //We just hide all apples in a loop :) it so good right ? :)
        for apple in appleArray {
            apple.isHidden = true
        }
        
        //We cast it to int because func is not returning an int
        let random = Int.random(in: 0..<9)
        appleArray[random].isHidden = false// and we randomly selected one visible
    }
    
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "Time : \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            //this is for when the game is over, hide all apples
            for apple in appleArray {
                apple.isHidden = true
            }
            //highscore saving
            if self.score > self.highScore {
                self.highScore = self.score
                self.highScoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            
            
            
            //Alert
            let alert = UIAlertController(title: "Time's UP!", message: "Wanna play Again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Time : \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.hideApple), userInfo: nil, repeats: true)
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }


}

