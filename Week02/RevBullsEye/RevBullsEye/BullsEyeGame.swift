//
//  BullsEyeGame.swift
//  BullsEyeW2HW
//
//  Created by Islombek Hasanov on 6/8/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

class BullsEyeGame {

    var currentValue: Int
    var targetValue: Int
    var score: Int
    var round: Int

    init(currentValue: Int = 0, targetValue: Int = 0, score: Int = 0, round: Int = 0) {
        self.currentValue = 0
        self.targetValue = 0
        self.score = 0
        self.round = 0
    }

    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
    }

    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }

    func getScoreMessage() -> (String, String) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference

        score += points

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

        let message = "You scored \(points) points"

        return (title, message)
    }
}
