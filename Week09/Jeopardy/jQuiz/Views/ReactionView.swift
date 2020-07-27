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

    func setText(_ text: String? = nil) {
        if let text = text {
            label.text = text
        } else {
            let positiveMessage = "\(positiveEmojis.randomElement()!) \(positiveTexts.randomElement()!)"
            label.text = positiveMessage
        }
    }
}

