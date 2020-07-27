//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
        }
    }

    var game = JeopardyGame()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ClueCell", bundle: nil), forCellReuseIdentifier: ClueCell.reuseIdentifier)

        self.scoreLabel.text = "\(game.getPoints())"

        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }

        SoundManager.shared.playSound()
        updateViews()
    }

    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }

    func updateViews() {
        categoryLabel.text = game.currentAnswer?.category.title
        clueLabel.text = game.currentAnswer?.question
        scoreLabel.text = "\(game.getPoints())"
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.clues.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClueCell.reuseIdentifier, for: indexPath) as? ClueCell else {
            fatalError()
        }

        let clue = game.clues[indexPath.row]

        cell.clueLabel.text = clue.answer

        if game.showsAnswers() {
            cell.setImage(to: clue == game.currentAnswer ? .correct : .incorrect)
            cell.statusImageView.isHidden = false
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        game.didSelect(clueAt: indexPath.row)
        updateViews()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .automatic)
    }
}

