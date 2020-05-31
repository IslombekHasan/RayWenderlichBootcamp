//
//  ViewController.swift
//  Bull's Eye
//
//  Created by Islombek Hasanov on 5/30/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    var round: Int = 0
    var totalScore: Int = 0
    var targetValue: Int = 0
    var currentValue: Int {
        get {
            return Int(slider.value.rounded())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func showAlert(_ sender: Any) {

        let difference = abs(targetValue - currentValue)
        var points = 100 - difference

        let title: String
        var message = "You scored \(points) points"

        if difference == 0 {
            title = "Perfect!"
            message += "\nHere's extra 100 points because you're so awesome! 🤩"
            points += 100
        } else if difference == 1 {
            title = "Just one!"
            message += "\nYou were off just one! Here's extra 50 points!"
            points += 50
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }

        totalScore += points

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func startNewGame() {
        round = 0
        totalScore = 0
        startNewRound()
    }

    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        slider.setValue(50, animated: true)
        updateLabels()
    }

    func updateLabels() {
        roundLabel.text = "\(round)"
        targetLabel.text = "\(targetValue)"
        scoreLabel.text = "\(totalScore)"
    }
}

