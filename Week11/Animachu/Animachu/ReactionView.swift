//
//  ReactionView.swift
//  jQuiz
//
//  Created by Islombek Hasanov on 7/27/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ReactionView: UIView {

    private let label = UILabel()
    private let positiveEmojis = ["🔥", "🎉", "🎊", "🥳", "❤️", "😎", "🤩", "😊"]
    private let positiveTexts = ["Way to go!", "I knew you could do it!", "That was a piece of cake!", "You're so smart!", "Awesooome!", "Couldn't be better!", "Just great!", "Awesomeness!", "Kudos to you!"]

    enum InitialPosition {
        case bottom
        case top
    }

    func setup() {
        // Style
        backgroundColor = .systemGray6
        layer.shadowOffset = .init(width: 0, height: 1.5)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.cornerRadius = 16


        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .systemGray
        label.text = "Hey there 🥳"

        // Layout
        self.addSubview(label)
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: label.widthAnchor, constant: 32),
            self.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override class var requiresConstraintBasedLayout: Bool {
        true
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: label.bounds.width + 48, height: label.bounds.height + 24)
    }

    static func showReaction(in view: UIView, from position: InitialPosition = .bottom, with text: String? = nil) {
        let reactionView = ReactionView()
        reactionView.setText(text)
        view.addSubview(reactionView)
        view.layoutIfNeeded()

        let contraint: NSLayoutConstraint
        let showConstant: CGFloat
        let hideConstant: CGFloat

        switch position {
        case .bottom:
            hideConstant = reactionView.frame.height
            showConstant = -reactionView.frame.height

            contraint = reactionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: hideConstant
            )

        case .top:
            hideConstant = -reactionView.frame.height
            showConstant = reactionView.frame.height

            contraint = reactionView.topAnchor.constraint(
                equalTo: view.topAnchor, constant: hideConstant
            )
        }

        NSLayoutConstraint.activate([
            contraint,
            reactionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.layoutIfNeeded()

        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2, animations: {
            contraint.constant = showConstant
            view.layoutIfNeeded()
        })

        UIView.animate(withDuration: 0.4, delay: 1.5, options: .curveEaseIn, animations: {
            contraint.constant = hideConstant
            view.layoutIfNeeded()
        }) { _ in reactionView.removeFromSuperview() }
    }

    func setText(_ message: String? = nil, withEmoji: Bool = true) {

        var text = ""

        if withEmoji {
            text += "\(positiveEmojis.randomElement()!) "
        }

        text += message ?? "\(positiveTexts.randomElement()!)"
        label.text = text

    }
}

