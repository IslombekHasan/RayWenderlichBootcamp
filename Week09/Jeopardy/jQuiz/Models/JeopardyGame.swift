//
//  JeopardyGame.swift
//  jQuiz
//
//  Created by Islombek Hasanov on 7/27/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

protocol JeopardyGameDelegate: class {
    func didSelect(correctClue correct: Bool)
}

class JeopardyGame {

    public private(set) var currentAnswer: Clue?
    private var points = 0
    private var showAnswersBool = false

    var clues: [Clue] {
        didSet {
            let randomSource = GKRandomSource.sharedRandom()
            clues = randomSource.arrayByShufflingObjects(in: clues) as! [Clue]
        }
    }

    init() {
        clues = []
        startGame()
    }

    public func getPoints() -> Int {
        points
    }

    public func showsAnswers() -> Bool {
        showAnswersBool
    }

    public func startGame() {
        reset()
        loadDummyData()
    }

    public func didSelect(_ clue: Clue) {
        let correct = clue == currentAnswer
        if correct { points += clue.value ?? 100 }
        showAnswersBool = true
    }

    public func didSelect(clueAt index: Int) {
        let clue = clues[index]
        didSelect(clue)
    }

    public func nextQuestion() {
        // TODO: - do this
        showAnswersBool = false
    }

    public func reset() {
        clues = []
        points = 0
        currentAnswer = nil
    }

    func loadDummyData() {
        let decoder = JSONDecoder()
        if let url = Bundle.main.url(forResource: "DummyData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let array = try decoder.decode([Clue].self, from: data)
                clues = array
                currentAnswer = clues.randomElement()
            } catch {
                print(error)
            }
        }
    }
}
