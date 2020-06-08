/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    let game = BullsEyeGame()
    var rgb = RGB()

    @IBAction func aSliderMoved(sender: UISlider) {
        let r = Int(redSlider.value.rounded())
        let g = Int(greenSlider.value.rounded())
        let b = Int(blueSlider.value.rounded())
        game.currentValue = RGB(r: r, g: g, b: b)
        guessLabel.backgroundColor = UIColor(rgbStruct: game.currentValue)
        updateGuessLabels()
        coldOrWarm()
    }

    @IBAction func showAlert(sender: AnyObject) {
        let (title, message) = game.getScoreMessage()

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.game.startNewRound()
            self.updateView()
        })

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func startOver(sender: AnyObject? = nil) {
        game.startNewGame()
        updateView()
    }

    func updateGuessLabels() {
        redLabel.text = String(Int(redSlider.value.rounded()))
        greenLabel.text = String(Int(greenSlider.value.rounded()))
        blueLabel.text = String(Int(blueSlider.value.rounded()))
    }

    func updateView() {
        targetLabel.backgroundColor = UIColor(rgbStruct: game.targetValue)
        guessLabel.backgroundColor = UIColor(rgbStruct: game.currentValue)
        (scoreLabel.text, roundLabel.text) = game.getValues()
        redSlider.value = 127
        greenSlider.value = 127
        blueSlider.value = 127
        updateGuessLabels()
        coldOrWarm()
    }

    func coldOrWarm() {
        let r = abs(game.currentValue.r - game.targetValue.r)
        let g = abs(game.currentValue.g - game.targetValue.g)
        let b = abs(game.currentValue.b - game.targetValue.b)
        redSlider.minimumTrackTintColor =
            UIColor.blue.withAlphaComponent(CGFloat(r) / 100.0)
        greenSlider.minimumTrackTintColor =
            UIColor.blue.withAlphaComponent(CGFloat(g) / 100.0)
        blueSlider.minimumTrackTintColor =
            UIColor.blue.withAlphaComponent(CGFloat(b) / 100.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
        coldOrWarm()
    }
}

