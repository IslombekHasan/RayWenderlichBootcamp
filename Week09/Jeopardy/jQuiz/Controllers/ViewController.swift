//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets and Variables
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
            tableView.isScrollEnabled = false
            tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        }
    }

    var game = JeopardyGame()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ClueCell", bundle: nil), forCellReuseIdentifier: ClueCell.reuseIdentifier)
        game.delegate = self
        updateViews()
    }
}

// MARK: - Controller methods
extension ViewController {

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

    func showReaction() {
        let reactionView = ReactionView()
        reactionView.setText()
        view.addSubview(reactionView)

        let bottomConstraint = reactionView.bottomAnchor.constraint(
            equalTo: view.bottomAnchor, constant: reactionView.frame.height
        )

        NSLayoutConstraint.activate([
            bottomConstraint,
            reactionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.layoutIfNeeded()


        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, animations: {
            bottomConstraint.constant = reactionView.frame.height * -2
            self.view.layoutIfNeeded()
        })

        UIView.animate(withDuration: 0.4, delay: 1.5, options: .curveEaseIn, animations: {
            bottomConstraint.constant = reactionView.frame.height
            self.view.layoutIfNeeded()
        }) { _ in reactionView.removeFromSuperview() }
    }
}
// MARK: - Jeopardy Game Delegate
extension ViewController: JeopardyGameDelegate {
    func didReceiveNewQuestion() {
        DispatchQueue.main.async {
            self.updateViews()
            self.tableView.reloadData()
        }
    }

    func didSelect(correctClue correct: Bool) {
        if correct { self.showReaction() }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.game.nextQuestion()
        }
    }

}

// MARK: - TableView Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.clues.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClueCell.reuseIdentifier, for: indexPath) as? ClueCell else {
            fatalError()
        }

        let clue = game.clues[indexPath.row]

        cell.clueLabel.text = clue.answer
        cell.statusImageView.isHidden = true

        if game.showsAnswers() {
            cell.setImage(to: clue == game.currentAnswer ? .correct : .incorrect)
            cell.statusImageView.isHidden = false
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("selecteddddd......")

        game.didSelect(clueAt: indexPath.row)
        updateViews()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .automatic)
        let cell = tableView.cellForRow(at: indexPath) as! ClueCell
        let color = cell.containerView.backgroundColor

        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            cell.containerView.backgroundColor = .systemGray3
        }) { _ in
//            UIView.animate(withDuration: 0.2) {
            cell.containerView.backgroundColor = color
//            }
        }
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if game.showsAnswers() {
            return false
        }
        return true
    }
}

