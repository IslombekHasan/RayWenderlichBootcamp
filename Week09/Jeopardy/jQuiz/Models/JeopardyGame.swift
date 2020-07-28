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
    func didReceiveNewQuestion()
}

class JeopardyGame {

    public private(set) var currentAnswer: Clue?
    private var points = 0
    private var showAnswersBool = false

    weak var delegate: JeopardyGameDelegate?

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

    public func startGame() {
        reset()
        //        loadDummyData()
        nextQuestion()
    }

    public func reset() {
        clues = []
        points = 0
        currentAnswer = nil
    }

    public func nextQuestion() {
        fetchRandomCategory { (clue) in
            self.currentAnswer = clue
            self.fetchAllClues(in: clue.categoryID) { (newClues) in
                self.clues = newClues
                self.showAnswersBool = false // this won't let the row to be selected until it's set to false
                self.delegate?.didReceiveNewQuestion()
            }
        }
    }

    public func getPoints() -> Int {
        points
    }

    public func showsAnswers() -> Bool {
        showAnswersBool
    }

    public func didSelect(clueAt index: Int) {
        let clue = clues[index]
        didSelect(clue)
    }

    public func didSelect(_ clue: Clue) {
        let correct = clue == currentAnswer
        if correct { points += clue.value ?? 100 }
        showAnswersBool = true
        delegate?.didSelect(correctClue: correct)
    }

    func fetchRandomCategory(_ completion: @escaping (_ clue: Clue) -> ()) {
        Networking.shared.getRandomCategory { data in
            do {
                let clue = try JSONDecoder().decode([Clue].self, from: data)[0]

                if (clue.question.isEmpty) {
                    print("Empty question... Retrying...")
                    self.fetchRandomCategory(completion)
                } else {
                    completion(clue)
                }
            } catch {
                print("Something is wrong with the data... \(error) /n Retrying...")
                // if cannot decode, that means that one or some of the fields are nil, so we're gonna fetch again.
                self.fetchRandomCategory(completion)
            }
        }
    }

    func fetchAllClues(in category: Int, _ completion: @escaping (_ clues: [Clue]) -> ()) {
        Networking.shared.getAllClues(in: category) { data in
            do {
                var newClues = try JSONDecoder().decode([Clue].self, from: data)
                if let indexOfAnswer = newClues.firstIndex(of: self.currentAnswer!) {
                    newClues.remove(at: indexOfAnswer)
                }
                let numberOfCluesToLeave = newClues.count >= 3 ? 3 : newClues.count
                newClues = Array(newClues.shuffled().prefix(numberOfCluesToLeave))
                newClues.insert(self.currentAnswer!, at: Int.random(in: 0..<3))

                completion(newClues)
            } catch {
                print(error)
            }
        }
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
