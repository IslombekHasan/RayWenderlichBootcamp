//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let game = BullsEyeGame()

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
        game.startNewGame()
    }

    @IBAction func showAlert() {

        let (title, message) = game.getScoreMessage()

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.game.startNewRound()
            self.updateViews()
        })

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
    }

    func updateViews() {
        (targetLabel.text, scoreLabel.text, roundLabel.text) = game.getValues()
        slider.value = 50
    }

    @IBAction func startNewGame() {
        game.startNewGame()
        updateViews()
    }

}



