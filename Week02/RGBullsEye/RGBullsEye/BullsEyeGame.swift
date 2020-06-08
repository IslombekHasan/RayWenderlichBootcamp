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

import Foundation

class BullsEyeGame {

    var currentValue: RGB
    var targetValue: RGB
    var score: Int
    var round: Int

    init(currentValue: RGB = RGB(), targetValue: RGB = RGB(), score: Int = 0, round: Int = 0) {
        self.currentValue = currentValue
        self.targetValue = targetValue
        self.score = 0
        self.round = 0
    }

    func startNewRound() {
        round += 1
        let r = Int.random(in: 0...255)
        let g = Int.random(in: 0...255)
        let b = Int.random(in: 0...255)
        targetValue = RGB(r: r, g: g, b: b)
        currentValue = RGB()
    }

    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }

    func getValues() -> (String, String) {
        (String(score), String(round))
    }

    func getScoreMessage() -> (String, String) {
        let difference = (currentValue.difference(target: targetValue) * 100).rounded()
        print(difference)
        var points = 100 - Int(difference)

        let title: String
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
            title = "Not even close..."
        }
        
        score += points

        let message = "You scored \(points) points"

        return (title, message)
    }
}

