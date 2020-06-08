//
//  ViewController.swift
//  RevBullsEye
//
//  Created by Islombek Hasanov on 6/8/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let game = BullsEyeGame()

    @IBOutlet weak var hitMeButton: UIButton!
    @IBOutlet weak var guessNumber: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var warmOrColdView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        warmOrColdView.layer.cornerRadius = 8
        warmOrColdView.layer.shadowRadius = 8
        warmOrColdView.layer.shadowColor = UIColor.black.cgColor
        warmOrColdView.layer.shadowOpacity = 0.5


        guessNumber.delegate = self
        guessNumber.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)

        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
        startOver()

    }
    @IBAction func userTapped(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func hitMe(_ sender: UIButton) {

        let (title, message) = game.getScoreMessage()

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.game.startNewRound()
            self.resetViews()
        })

        alert.addAction(action)

        present(alert, animated: true, completion: nil)

    }

    func resetViews() {
        (slider.value, scoreLabel.text, roundLabel.text) = (Float(game.targetValue), String(game.score), String(game.round))
        guessNumber.text = nil
        hitMeButton.isEnabled = false
        warmOrCold()
    }

    @IBAction func startOver() {
        game.startNewGame()
        resetViews()
    }

    func warmOrCold() {
        let diff = abs(game.currentValue - game.targetValue)
        if (diff > 5) {
            warmOrColdView.backgroundColor = UIColor.blue.withAlphaComponent(CGFloat(diff) / 100.0)
        } else {
            warmOrColdView.backgroundColor = UIColor.red.withAlphaComponent(CGFloat(100 - diff) / 100.0)
        }
    }

    // watch for textField changes
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let num = Int(textField.text! + string) {
            return num <= 100
        }

        return true
    }

    private var lastValue = ""
    @objc private func editingChanged(_ textField: UITextField) {
        if let num = Int(textField.text!) {
            game.currentValue = num
            warmOrCold()
            hitMeButton.isEnabled = true
        } else {
            hitMeButton.isEnabled = false
        }
    }

}

