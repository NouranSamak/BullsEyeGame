//
//  ViewController.swift
//  BullsEye
//
//  Created by Admin on 8/19/18.
//  Copyright © 2018 Nouran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var currentRound = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewGame()
        
        let thumbImgNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        //let thumbImgNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImgNormal, for: .normal)
        
        let thumbImgHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImgHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImg = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImg.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImg = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImg.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        
        var points = 100 - difference
        
        let title : String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close!"
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })

//        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
//        startNewRound()
        
    }
    
    func startNewRound() {
        currentRound += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
            targetLabel.text = String(targetValue)
            scoreLabel.text = String(score)
            roundLabel.text = String(currentRound)
    }
    
    @IBAction func startNewGame() {
        currentRound = 0
        score = 0
        startNewRound()
    }

}

